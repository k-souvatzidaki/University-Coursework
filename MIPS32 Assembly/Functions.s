#Author: Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB

	.text
	.globl main
main:
	#-----------------------
	# $t0 = the user's option from the menu
	# $a0-$a3 = used to pass arguments
	#-----------------------
	
	#print all the options
	li $v0,4
	la $a0,menu
	syscall
		
switch:
	li $v0,4 #print(" What to do next? \n ")
	la $a0,op
	syscall
	
	#read answer
	li $v0,5
	syscall
	move $t0,$v0
		
	case1: 
		bne $t0,1,case2
		#readPin(int[] pinA)
		la $a0,pinA
		jal readPin
		j endSwitch #insert new answer
		
	case2: 
		bne $t0,2,case3
		#readPin(int[] pinB)
		la $a0,pinB
		jal readPin
		j endSwitch #insert new answer
		
	case3: 
		bne $t0,3,case4
		#createSparse(int[] A, int[] sparseA) 
		la $a0,pinA
		la $a1,sparseA
		jal createSparse
		#sizeA = createSparse return value ($v0)
		sw $v0,sizeA
		j endSwitch #insert new answer
		
	case4: 
		bne $t0,4,case5
		#createSparse(int[] B, int[] sparseB) 
		la $a0,pinB
		la $a1,sparseB
		jal createSparse
		#sizeB = createSparse return value ($v0)
		sw $v0, sizeB
		j endSwitch #insert new answer
		
	case5: 
		bne $t0,5,case6
		la $a0,sparseA
		lw $a1,sizeA
		la $a2,sparseB
		la $a3,sparseC
		
		#push 5th argument to the stack
		addi $sp,$sp,-4
		lw $t0,sizeB
		sw $t0,0($sp)
		
		jal addArrays
		
		sw $v0,sizeC
		
		j endSwitch #insert new answer
	case6: 
		bne $t0,6,case7
		la $a0,sparseA
		lw $a1,sizeA
		jal printSparse
		j endSwitch #insert new answer
		
	case7: 
		bne $t0,7,case8
		la $a0,sparseB
		lw $a1,sizeB
		jal printSparse
		j endSwitch #insert new answer
		
	case8: 
		bne $t0,8,case0
		la $a0,sparseC
		lw $a1,sizeC
		jal printSparse
		j endSwitch #insert new answer
		
	case0: 
		bne $t0,0,endSwitch
		j exit

endSwitch: j switch		
		
exit:
	li $v0,10
	syscall
	
	
#----------------- FUNCTIONS ------------------#
	
#void readPin(int[] pin){
#	for(int i=0; i<pin.length; i++){
#		pin[i]= readInt("Position" + i +":");
#}


#-----------------------
# $t0= counter in function
# $t1= base register in function
# ARGS
# $a0 = array base register (pass by reference)
#-----------------------

readPin:
	li $t0,0 # counter i = 0
	move $t1, $a0  # $t1= arg array base reg
	li $v0,4 # print(" Insert 10 integers ");
	la $a0,mes
	syscall
loop:
	beq $t0,10,end #if i=10 end
	#lw $t2,($t1) # array[i]
	li $v0,4 # print("Position ");
	la $a0,mesb
	syscall
	li $v0,1 #print i
	move $a0,$t0
	syscall
	li $v0,4 #print(": ");
	la $a0,mesc
	syscall
	li $v0,5
	syscall
	#move $t2,$v0 # the result in array[i]
	sw $v0, ($t1)
	addi $t1,$t1,4 # increase base register
	addi $t0,$t0,1 # increase the counter 
	j loop
end:
	jr $ra

#-----------------------------------------------

#int createSparse(int[] pin, int[] sparse){
#	int i, k=0;
#	for(i=0;i<pin.length; i++){
#		if(pin[i] !=0){
#			sparse[k++] = i;
#			sparse[k++] = pin[i];
#		}
#	}
#	return k;
#}

#-----------------------
# $t0 = int i
# $t1 = int k
# $t2 = array base register in function
# $t3 = sparse array base register in function
# $t4 = current array element
# ARGS
# $a0 = array base register
# $a1 = sparse array base register (pass by reference)
#-----------------------

createSparse:
	li $t0,0 #i=0
	li $t1,0 #k=0
	move $t2, $a0  # $t2= arg pin array base reg
	move $t3, $a1  # $t3= arg sparse array base reg
	li $v0,4 # print("Sparse Array Created Successfully!");
	la $a0,mes2
	syscall
loop2: 
	beq $t0,10,endloop2 #if i=10 end
	lw $t4,($t2) # pin[i]
	beqz $t4,syn #if pin[i]==0
	sw $t0,($t3) #current sparse element = i
	addi $t1,$t1,1 #k++
	addi $t3,$t3,4 #next sparse element
	sw $t4, ($t3) #current sparse element = pin[i] ($t4)
	addi $t1,$t1,1 #k++
	addi $t3,$t3,4 #next sparse element
		
syn:
	addi $t0,$t0,1 #i++
	addi $t2,$t2,4 #next pin element
	j loop2
endloop2:
	move $v0,$t1 #k= result
	jr $ra #return
	
#-----------------------------------------------

#void printSparse(int[] sparse, int mikos){
#	for(int i=0; i< mikos;){
#		println("Position: + sparse[i++] +" Value: " + sparse[i++]);
#	}
#}

#-----------------------
# %t0 = sparse array base register in function
# $t1 = counter (int i)
# %t2 = current element
# ARGS
# $a0 = sparse array base register (pass by reference)
# $a1 = sparse array size
#-----------------------

printSparse:
	move $t0,$a0 #sparse base register
	li $t1,0 # int i =0
	li $v0,4 #print( "Printing Sparse Array ");
	la $a0,mes3c
	syscall
loop3:
	beq $t1,$a1,endloop3 #if i= mikos end loop
	li $v0,4 #print("Position: ");
	la $a0,mes3
	syscall
	lw $t2,($t0) #print the position from sparse array
	move $a0,$t2
	li $v0,1
	syscall
	addi $t0,$t0,4 #next sparse array element
	li $v0,4 #print( " Value: ");
	la $a0,mes3b
	syscall
	lw $t2,($t0) #print the value from sparse array 
	move $a0,$t2
	li $v0,1
	syscall
	li $v0,4 #print a new line
	la $a0,nl
	syscall
	addi $t0,$t0,4 #next sparse array element
	addi $t1,$t1,2	#increase i by 2
	j loop3 #again
endloop3:
	jr $ra #return


#-----------------------------------------------

#int add( int[] sparseA, int mikosA, int[] sparseB, int mikosB, int[] sparseC){
#	int a,b,c;
#	for(a=0, b=0, c=0; a<mikosA && b<mikosB){
#		if( sparseA[a] < sparseB[b] ){
#			sparseC[c++] = sparseA[a++];
#			sparseC[c++] = sparseA[a++];
#		}else if( sparseA[a] > sparseB[b] ){
#			sparseC[c++] = sparseB[b++];
#			sparseC[c++] = sparseB[b++];
#		}else{
#			sparseC[c++] = sparseA[a++];
#			b++;
#			sparseC[c++] = sparseA[a++] + sparseB[b++];
#		}
#	}
#	for(a < mikosA){
#		sparseC[c++] = sparseA[a++];
#		sparseC[c++] = sparseA[a++];
#	}
#	for(b < mikosB){
#		sparseC[c++] = sparseB[b++];
#		sparseC[c++] = sparseB[b++];
#	}
#	return c;
#}

#-----------------------
# $t0 = int a
# $t1 = int b 
# $t2 = int c
# ARGS
# $a0 = sparse array A base register
# $a1 = sparse array A size 
# $a2 = sparse array B base register
# $a3 = sparse array C base register
# stack -> sparse array B size
#-----------------------

addArrays:
	li $t0,0
	li $t1,0
	li $t2,0
	move $t3,$a0 #sparse array A base register
	move $t4,$a2 #sparse array B base register
	move $t5,$a3 #sparse array C base register
	#pushing the extra argument from the stack
	lw $t6, 0($sp) 
	addi $sp,$sp,4
	lw $t7,($t3) #sparseA[0]
	lw $t8,($t4) #sparseB[0]
for1:
	beq $t0,$a1,endfor1
	beq $t1,$t6,endfor1
	
	bge $t7,$t8,elseif
	sw $t7,($t5)
	addi $t5,$t5,4
	addi $t3,$t3,4
	lw $t7,($t3)
	sw $t7,($t5)
	addi $t5,$t5,4
	addi $t3,$t3,4
	lw $t7,($t3)
	addi $t2,$t2,2
	addi $t0,$t0,2
	j for1
	
elseif:
	bge $t8,$t7,else
	sw $t8,($t5)
	addi $t5,$t5,4
	addi $t4,$t4,4
	lw $t8,($t4)
	sw $t8,($t5)
	addi $t5,$t5,4
	addi $t4,$t4,4
	lw $t8,($t4)
	addi $t2,$t2,2
	addi $t1,$t1,2
	j for1
	
else:
	sw $t7,($t5)
	addi $t5,$t5,4
	addi $t3,$t3,4
	lw $t7,($t3)
	addi $t4,$t4,4
	lw $t8,($t4)
	add $t8,$t8,$t7
	sw $t8,($t5)
	addi $t5,$t5,4
	addi $t3,$t3,4
	lw $t7,($t3)
	addi $t4,$t4,4
	lw $t8,($t4)
	addi $t0,$t0,2
	addi $t1,$t1,2
	addi $t2,$t2,2
	j for1
	
endfor1:
	
for2:
	bge $t0,$a1,endfor2
	sw $t7,($t5)
	addi $t5,$t5,4
	addi $t3,$t3,4
	lw $t7,($t3)
	sw $t7,($t5)
	addi $t5,$t5,4
	addi $t3,$t3,4
	lw $t7,($t3)
	addi $t0,$t0,2
	addi $t2,$t2,2
	j for2
	
endfor2:

for3:
	bge $t1,$t6,endfor3
	sw $t8,($t5)
	addi $t5,$t5,4
	addi $t4,$t4,4
	lw $t8,($t4)
	sw $t8,($t5)
	addi $t5,$t5,4
	addi $t4,$t4,4
	lw $t8,($t4)
	addi $t1,$t1,2
	addi $t2,$t2,2
	j for2
	
endfor3:
	
	move $v0,$t2 #return value = sizeC
	jr $ra #return


#-----------------------------------------------
	   .data
menu:  .asciiz " 1. Read Array A \n 2. Read Array B \n 3. Create Sparse Array A \n 4. Create Sparse Array B \n 5. Create Sparse Array C = A + B \n 6. Display Sparse Array A \n 7. Display Sparse Array B \n 8. Display Sparse Array C \n 0. Exit \n"
op:    .asciiz " What to do next? \n"
pinA:  .space 40
pinB:  .space 40
sparseA: .space 80
sparseB: .space 80
sparseC: .space 160
sizeA: .word 0
sizeB: .word 0
sizeC: .word 0
mes:   .asciiz "Insert 10 integers. . .  \n"
mesb:  .asciiz "Position "
mesc: .asciiz " : \n"
mes2: .asciiz "Sparse Array Created Successfully! \n"
mes3:  .asciiz "Position: "
mes3b: .asciiz " Value: "
mes3c: .asciiz "Printing Sparse Array. . . \n"
nl:	   .asciiz "\n"