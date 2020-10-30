#include "tickets.h"

//global variables and mutexes

//bank account
unsigned int bank_account =0;
pthread_mutex_t account_lock;
//transaction counters
unsigned int transaction_counter=0;
pthread_mutex_t transaction_counter_lock;
unsigned int venue_full_counter=0;
pthread_mutex_t venue_full_counter_lock;
unsigned int not_enough_seats_counter=0;
pthread_mutex_t not_enough_seats_counter_lock;
//average waiting time
double avg_waiting_time=0.0;
pthread_mutex_t avg_waiting_time_lock;
//average service time
double avg_service_time=0.0;
pthread_mutex_t avg_service_time_lock;
//available telephone operators
unsigned int available_telephone_operators=Ntel;
pthread_mutex_t operator_lock;
pthread_cond_t operator_cond_v=PTHREAD_COND_INITIALIZER; //condition variable
//available cashiers
unsigned int available_cashiers=Ncash;
pthread_mutex_t cashier_lock;
pthread_cond_t cashier_cond_v=PTHREAD_COND_INITIALIZER; //condition variable
//seat plan
int seat_plan[NzoneA + NzoneB +  NzoneC][Nseat];
//screen lock mutex
pthread_mutex_t seat_plan_lock;
pthread_mutex_t screen_output_lock;
//random seed
int seed;

//function
void *customer(void *tid){

	int err;
	struct timespec start_waiting,finish_waiting,start_service,finish_service;
	long seconds,nanoseconds;

	//lock the telephone operators count mutex
	err = pthread_mutex_lock(&operator_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_lock() is %d\n",err);
		pthread_exit(&err);
	}

	//start service time
	clock_gettime(CLOCK_REALTIME,&start_service);
	//start waiting time
    	clock_gettime(CLOCK_REALTIME,&start_waiting);

	//check for available telephone operators
	while(available_telephone_operators==0){
		//print message
		err= pthread_mutex_lock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		printf("Customer %d : No telephone operators available. Customer on hold. . .\n",(int*)tid);
		err= pthread_mutex_unlock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);

		}

		//wait for a telephone to be freed
		err = pthread_cond_wait(&operator_cond_v,&operator_lock);
		if(err!=0){
			printf("Error: return code from pthread_cond_wait() is %d\n",err);
			pthread_exit(&err);
		}

	}

	//finish waiting time
	clock_gettime(CLOCK_REALTIME,&finish_waiting);

	//one less telephone operator available
	available_telephone_operators--;
	//unlock telephone operator mutex
	err= pthread_mutex_unlock(&operator_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
		pthread_exit(&err);
	}

	//adding waiting time
    	seconds = finish_waiting.tv_sec - start_waiting.tv_sec;
    	nanoseconds = finish_waiting.tv_nsec - start_waiting.tv_nsec;

	//clock underflow
   	if(start_waiting.tv_nsec > finish_waiting.tv_nsec) {--seconds; nanoseconds+= 1000000000;}

	//lock avg waiting time mutex
   	err= pthread_mutex_lock(&avg_waiting_time_lock);
   	if(err!=0){
        	printf("Error: return code from pthread_mutex_lock() is %d\n",err);
        	pthread_exit(&err);
    	}
    	avg_waiting_time += (double)seconds + (double)nanoseconds/(double)1000000000;
	//unlock avg waiting time mutex
    	err= pthread_mutex_unlock(&avg_waiting_time_lock);
   	if(err!=0){
        	printf("Error: return code from pthread_mutex_lock() is %d\n",err);
        	pthread_exit(&err);
    	}

    	//pick a zone
    	int zone = prob(PzoneA,PzoneB,PzoneC);

	//customer number of seats chosen randomly
	int num_of_seats = rand_r(&seed)%(Nseathigh + 1 - Nseatlow) + Nseatlow;
	//waiting seconds chosen randomly
	int waiting_seconds = rand_r(&seed)%(tseathigh + 1 - tseatlow) + tseatlow;

	sleep(waiting_seconds);


	//lock the seat plan array mutex
	err = pthread_mutex_lock(&seat_plan_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_lock() is %d\n",err);
		pthread_exit(&err);
	}

	//check if there are enough seats
	int cnt=num_of_seats,i,upto,boolean=0,j;
	//pick the part of the venue that should be searched for seats, according to the zone
	if(zone == 1){
        	i=0;
        	upto=NzoneA;
    	}else if(zone==2){
        	i=NzoneA;
        	upto=NzoneA + NzoneB;
    	}else{
        	i=NzoneA + NzoneB;
        	upto=NzoneA + NzoneB  + NzoneC;
    	}

    	int seats[num_of_seats]; int k;

   	 while(i< upto && cnt > 0) {
        	j=0;
        	cnt = num_of_seats;
        	k=0;
        	while(j<Nseat){
          		if(seat_plan[i][j]==0 && cnt!=0) {
                		cnt--;
                		boolean=1;
                		seats[k]=j;
                		k++;
            		}else {
                		cnt = num_of_seats;
                		k=0;
            		}
            		if(cnt==0) j=Nseat;
            		j++;
        	}
        	if(cnt==0) continue;
        	i++;
    	}


	//if the venue is full
	if(boolean == 0 ){

		//add this transaction to the failed ones due to the venue being full
 		err= pthread_mutex_lock(&venue_full_counter_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		venue_full_counter++;
		err= pthread_mutex_unlock(&venue_full_counter_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}


        	//finish service time
		clock_gettime(CLOCK_REALTIME,&finish_service);

		//adding service time
		seconds = finish_service.tv_sec - start_service.tv_sec;
		nanoseconds = finish_service.tv_nsec - start_service.tv_nsec;
		//clock underflow
		if(start_service.tv_nsec > finish_service.tv_nsec) {--seconds; nanoseconds+= 1000000000;}

		err= pthread_mutex_lock(&avg_service_time_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		avg_service_time += (double)seconds + (double)nanoseconds/(double)1000000000;
		err= pthread_mutex_unlock(&avg_service_time_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}

		//print message
		err= pthread_mutex_lock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		printf("Customer %d :The venue is full.Booking is cancelled.\n",(int*)tid);
		err= pthread_mutex_unlock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);

		}

		//unlock seat plan mutex
		err = pthread_mutex_unlock(&seat_plan_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
		//free a telephone operator
		err= pthread_mutex_lock(&operator_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		available_telephone_operators++;
		//signal a waiting thread
		err =pthread_cond_signal(&operator_cond_v);
		if(err!=0){
			printf("Error: return code from pthread_cond_signal() is %d\n",err);
			pthread_exit(&err);
		}
		err= pthread_mutex_unlock(&operator_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
		//exit
		pthread_exit(NULL);
	}

	//if there are not enough seats
	if(cnt > 0) {

		//add this transaction to the failed ones due to not enough seats being available
       		err= pthread_mutex_lock(&not_enough_seats_counter_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		not_enough_seats_counter++;
		err= pthread_mutex_unlock(&not_enough_seats_counter_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}

        	//finish service time
		clock_gettime(CLOCK_REALTIME,&finish_service);

		//adding service time
		seconds = finish_service.tv_sec - start_service.tv_sec;
		nanoseconds = finish_service.tv_nsec - start_service.tv_nsec;
		//clock underflow
		if(start_service.tv_nsec > finish_service.tv_nsec) {--seconds; nanoseconds+= 1000000000;}

		err= pthread_mutex_lock(&avg_service_time_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		avg_service_time += (double)seconds + (double)nanoseconds/(double)1000000000;
		err= pthread_mutex_unlock(&avg_service_time_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}

		//print message
		err= pthread_mutex_lock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}

		printf("Customer %d :Seats not found. Booking is cancelled.\n",(int*)tid);
		err= pthread_mutex_unlock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);

		}

		//unlock seat plan mutex
		err = pthread_mutex_unlock(&seat_plan_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
		//free a telephone operator
		err= pthread_mutex_lock(&operator_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		available_telephone_operators++;
		//signal a waiting operator
		err =pthread_cond_signal(&operator_cond_v);
		if(err!=0){
			printf("Error: return code from pthread_cond_signal() is %d\n",err);
			pthread_exit(&err);
		}
		err= pthread_mutex_unlock(&operator_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
		//exit
		pthread_exit(NULL);
	}

	//keep the seats found for the customer in the seat plan
   	for(int h =0; h<k; h++) {
        	seat_plan[i][seats[h]]=(int*)tid;
    	}

   	//unlock seat plan mutex
	err = pthread_mutex_unlock(&seat_plan_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
		pthread_exit(&err);
	}


	//free a telephone operator
	err= pthread_mutex_lock(&operator_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_lock() is %d\n",err);
		pthread_exit(&err);
	}
	available_telephone_operators++;
	//signal a waiting thread
	err =pthread_cond_signal(&operator_cond_v);
	if(err!=0){
		printf("Error: return code from pthread_cond_signal() is %d\n",err);
		pthread_exit(&err);
	}
	err= pthread_mutex_unlock(&operator_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
		pthread_exit(&err);
	}



	//lock the cashier count mutex
	err = pthread_mutex_lock(&cashier_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_lock() is %d\n",err);
		pthread_exit(&err);
	}

	//start waiting time
    	clock_gettime(CLOCK_REALTIME,&start_waiting);

	//check for available cashiers
	while(available_cashiers==0){
		//print message
		err= pthread_mutex_lock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		printf("Customer %d : No cashier available. Customer on hold. . .\n",(int*)tid);
		err= pthread_mutex_unlock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);

		}

		//wait for a cashier to be freed
		err = pthread_cond_wait(&cashier_cond_v,&cashier_lock);
		if(err!=0){
			printf("Error: return code from pthread_cond_wait() is %d\n",err);
			pthread_exit(&err);
		}

	}

	//finish waiting time
	clock_gettime(CLOCK_REALTIME,&finish_waiting);

	//one less cashier available
	available_cashiers--;
	//unlock cashier mutex
	err= pthread_mutex_unlock(&cashier_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
		pthread_exit(&err);
	}

	//adding waiting time
    	seconds = finish_waiting.tv_sec - start_waiting.tv_sec;
    	nanoseconds = finish_waiting.tv_nsec - start_waiting.tv_nsec;

	//clock underflow
   	if(start_waiting.tv_nsec > finish_waiting.tv_nsec) {--seconds; nanoseconds+= 1000000000;}

	//lock avg waiting time mutex
   	err= pthread_mutex_lock(&avg_waiting_time_lock);
    	if(err!=0){
        	printf("Error: return code from pthread_mutex_lock() is %d\n",err);
       	 	pthread_exit(&err);
    	}
    	avg_waiting_time += (double)seconds + (double)nanoseconds/(double)1000000000;
	//unlock avg waiting time mutex
    	err= pthread_mutex_unlock(&avg_waiting_time_lock);
   	if(err!=0){
        	printf("Error: return code from pthread_mutex_lock() is %d\n",err);
        	pthread_exit(&err);
    	}

	//get random seconds to wait for the cashier
    	waiting_seconds = rand_r(&seed)%(tcashhigh + 1 - tcashlow) + tcashlow;

	sleep(waiting_seconds);

	//payment
	if((rand()/(double)RAND_MAX) < Pcardsucces) { //if the card is accepted
        	int cost;
		//get price according to the zone
        	if(zone==1) cost += num_of_seats * CzoneA;
		else if(zone==2) cost += num_of_seats * CzoneB;
		else cost += num_of_seats * CzoneC;

		//lock account mutex
		err = pthread_mutex_lock(&account_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		//add money to account
		bank_account += cost;
		//unlock account mutex
		err = pthread_mutex_unlock(&account_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
		//increase transaction counter
		err = pthread_mutex_lock(&transaction_counter_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		transaction_counter++;
		err = pthread_mutex_unlock(&transaction_counter_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}

		//print message
		err= pthread_mutex_lock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}

		printf("Customer %d : Transaction completed.Transaction number = %d, zone = ",(int)tid,(int)tid);
		if(zone==1) printf("A"); else if(zone==2) printf("B"); else printf("C");
		printf(",row = %d ,seats are: ",i);
		for(int k=0; k<num_of_seats; k++) { printf("%d,",seats[k]); }
		printf(" and the transaction cost is %d .\n",cost);

		err=pthread_mutex_unlock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
	}else{
		//lock seat plan mutex and free the seats
		err = pthread_mutex_lock(&seat_plan_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		for(int h=0; h<k; h++) { seat_plan[i][seats[h]]=0;}

		err = pthread_mutex_unlock(&seat_plan_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}

		//print message
		err= pthread_mutex_lock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_lock() is %d\n",err);
			pthread_exit(&err);
		}
		printf("Customer %d : Booking failed.Card was not accepted.\n",(int*)tid);

		err=pthread_mutex_unlock(&screen_output_lock);
		if(err!=0){
			printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
			pthread_exit(&err);
		}
	}


	//finish service time
    	clock_gettime(CLOCK_REALTIME,&finish_service);

	//adding service time
    	seconds = finish_service.tv_sec - start_service.tv_sec;
    	nanoseconds = finish_service.tv_nsec - start_service.tv_nsec;
    	//clock underflow
    	if(start_service.tv_nsec > finish_service.tv_nsec) {--seconds; nanoseconds+= 1000000000;}

    	err= pthread_mutex_lock(&avg_service_time_lock);
    	if(err!=0){
        	printf("Error: return code from pthread_mutex_lock() is %d\n",err);
        	pthread_exit(&err);
    	}
    	avg_service_time += (double)seconds + (double)nanoseconds/(double)1000000000;
   
    	err= pthread_mutex_unlock(&avg_service_time_lock);
    	if(err!=0){
        	printf("Error: return code from pthread_mutex_lock() is %d\n",err);
        	pthread_exit(&err);
    	}


    	//free a cashier
	err= pthread_mutex_lock(&cashier_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_lock() is %d\n",err);
		pthread_exit(&err);
	}
	available_cashiers++;
	//signal a waiting thread
	err =pthread_cond_signal(&cashier_cond_v);
	if(err!=0){
		printf("Error: return code from pthread_cond_signal() is %d\n",err);
		pthread_exit(&err);
	}
	err= pthread_mutex_unlock(&cashier_lock);
	if(err!=0){
		printf("Error: return code from pthread_mutex_unlock() is %d\n",err);
		pthread_exit(&err);
	}

	//exit
	pthread_exit(NULL);

}


//main
int main(int argc,char ** argv){

	int err;
	//checking arguments
	if(argc!=3){printf("Error, wrong number of args!\n"); exit(-1);}
	int Ncust = atoi(argv[1]);
	if(Ncust<0) {printf("No customers found!!\n"); exit(-1);}

	//initializing threads array
	pthread_t *customers;
	customers=malloc(Ncust*sizeof(pthread_t));
	if(customers==NULL){printf("Not enough memory for customers!\n"); return -1;}

	//initializing random seed
	seed = atoi(argv[2]);

	//inititalizing mutexes
	err = pthread_mutex_init(&account_lock,NULL); //initializing bank account mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_init(&transaction_counter_lock,NULL); //initializing transaction counter mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_init(&avg_waiting_time,NULL); //initializing average waiting mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_init(&avg_service_time_lock,NULL); //initializing average service time mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_init(&operator_lock,NULL); //initializing operator lock mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_init(&cashier_lock,NULL); //initializing operator lock mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_init(&seat_plan_lock,NULL); //initializing seat plan mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}

	err = pthread_mutex_init(&screen_output_lock,NULL); //initializing screen output mutex!
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err=pthread_mutex_init(&venue_full_counter_lock,NULL);
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}
	err=pthread_mutex_init(&not_enough_seats_counter_lock,NULL);
	if(err!=0){
		printf("error: return code from pthread_mutex_create() is %d\n", err);
		exit(-1);
	}


	//initializing the seats array with 0
	for(int i=0; i< NzoneA + NzoneB +  NzoneC; i++) {
        	for(int j=0; j<Nseat; j++){
            		seat_plan[i][j]=0;
        	}
    	}


	//creating the threads
	for(int i=0; i<Ncust; i++){
   		err = pthread_create(&customers[i],NULL,customer,(void*)(i+1));
    		if(err!=0){
			printf("Error in creating thread %d from pthread_create() is %d\n",i+1,err);
			exit(-1);
		}
	}

	//join
	void * status;
	for(int i=0; i < Ncust; i++){
    		err =pthread_join(customers[i], &status);
    		if(err!=0){
			printf("error: return code from pthread_join() is %d\n", err);
			exit(-1);
		}
	}


	//print the seat plan
	int counter=1; char zone= 'A';
	for(int i=0; i<NzoneA + NzoneB +  NzoneC; i++) {
        	if(i==NzoneA){ counter =1; zone='B';}
        	if(i==NzoneA+NzoneB){ counter =1; zone='C';}
        	for(int j=0; j<Nseat;j++){
        	   	printf("Zone %c / Seat %d/ Customer: ",zone,counter);
            		if(seat_plan[i][j]==0) printf("seat is not booked.\n");
            		else printf("%d \n",seat_plan[i][j]);
            		counter++;
        	}
	}
	//other results
	printf("Total revenues from tickets = %d \n",bank_account);
	printf("Succesful transactions: %.*f %%\n",2,transaction_counter*100/(double)Ncust);
	printf("Failed transactions due to full venue: %.*f %%\n",2,venue_full_counter*100/(double)Ncust);
	printf("Failed transactions due to non-consequent seats: %.*f %%\n",2,not_enough_seats_counter*100/(double)Ncust);
	printf("Failed transactions due to not accepted card: %.*f %%\n",2,(Ncust-transaction_counter-venue_full_counter-not_enough_seats_counter)*100/(double)Ncust);
	printf("Average waiting time = %.*f \n",2,avg_waiting_time/(double)Ncust);
	printf("Average service time = %.*f \n",2,avg_service_time/(double)Ncust);

	//destroy mutexes
	err = pthread_mutex_destroy(&account_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&transaction_counter_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&avg_waiting_time_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&avg_service_time_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&operator_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&cashier_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&seat_plan_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}

	err = pthread_mutex_destroy(&screen_output_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&venue_full_counter_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_mutex_destroy(&not_enough_seats_counter_lock);
	if(err!=0){
		printf("error: return code from pthread_mutex_destroy() is %d\n", err);
		exit(-1);
	}
	//destroy condition variables
	err = pthread_cond_destroy(&operator_cond_v);
	if(err!=0){
		printf("error: return code from pthread_cond_destroy() is %d\n", err);
		exit(-1);
	}
	err = pthread_cond_destroy(&cashier_cond_v);
	if(err!=0){
		printf("error: return code from pthread_cond_destroy() is %d\n", err);
		exit(-1);
	}


	//free memory
	free(customers);
	return 0;
}

//function to pick a zone (A,B,C with probabilities px,py,pz)
int prob(double px,double py,double pz){

    int r = rand()% (100) +1;
	if(r <=px*100){
		return 1;
	}
	if(r <=(px*100+py*100)){
		return 2;
	}
	else{
		return 3;
	}

}
