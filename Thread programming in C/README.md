# Thread Programming in C

## About
This was a group project for the Operating Systems course. It's a ticket booking app in C. A number of customers want to book and pay for a number of seats on a venue, 
and a number of phone operators and cashiers are available to serve them. It's basically the **producer-consumer** problem with threads.
We implemented this on a virtual machine running Ubuntu Linux. 

## Description
We have a 2-dimension array representing the venue's seat plan, a number of telephone operators and a number of cashiers. For each new customer, a new **thread** is created.
    
The threads run the **customer** function, which implements the steps of a ticket booking:
1. Wait to be connected with a phone operator, if none is available when the thread is created.
2. Wait for seats to be found.
3. If the seats are available, wait to be connected with a cashier if none is available.
4. Proceed to the payment.
    
A transaction can fail for one of three reasons: 
1. The venue is full.
2. Can't find the number of consequent seats the customer wants.
3. The card was not accepted during the payment.
    
We are using the mutexes and condition variables of the **pthreads** package to synchronise the threads. 
Only one thread at a time is allowed to access any variable or array. We are using mutexes for this. Condition variables are used to signal each waiting thread when a phone operator or cashier is freed.
The **header** file includes all the constants and function signatures.

## Inputs
The inputs given to the program are the number of total customers, and a random number generator seed. 
The random generator is used to calculate the amount of time a customer waits for a payment to be done, and also the posibility for a credit card to not be accepted

## Outputs
The outputs are the total revenues from tickets ,the number of succesful and failed transactions, the average waiting and service times.

## Group
I did this project with [Foivos Charalampakos](https://github.com/wolfie00) and [Marilena Kokkini](https://github.com/MarilenaKokkini)
    
*Spring 2018-19*
