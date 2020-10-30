#Author: Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
#Description: the user gives two integers as input, then the greatest common divisor of those two is calculated, and the user has to find the answer.

#Registers used
#$a0 for arguments
#$v0 for loading instructions
#$t0 --> inta
#$t1 --> intb
#$t2 --> y (inta%intb)
#$t3 --> s (the user's answer)

	.text
	.globl main
main:
	#loading words
	lw $t0,inta
	lw $t1,intb
	lw $t2,y
	lw $t3,s
	#print("Insert an integer. ")
	li $v0,4  #print string syscall code 
	la $a0, p1 #p1: .asciiz "Insert an integer. "
	syscall
	#read int a
	li $v0,5 #read int syscall code
	syscall
	addi $t0,$v0,0 #first int input is stored in inta($t0)
	
	#print("Insert an integer. ")
	li $v0,4  #print string syscall code 
	la $a0, p1 #p1: .asciiz "Insert an integer. "
	syscall
	#read int b
	li $v0,5 #read int syscall code
	syscall
	addi $t1,$v0,0 #second int input is stored in intb($t1)
	
	#print("What is the greatest common divisor of"+a+"and"+b+"?")
	la $a0,q1 #q1: .asciiz "What is the greatest common divisor of "
	li $v0,4 #print string syscall code
	syscall
	addi $a0,$t0,0 #inta($t0) is now an argument
	li $v0,1 #print int syscall code
	syscall
	la $a0, q2 #q2: .asciiz " and "
	li $v0,4 #print string syscall code
	syscall
	addi $a0,$t1,0 #intb($t1) is now an argument
	li $v0,1 #print int syscall code
	syscall
	la $a0, q3 #q3: .asciiz "?"
	li $v0,4 #print string syscall code
	syscall
	
	
	#y=a%b
	rem $t2,$t1,$t0
	jal loopo
	#while loop 1
loopo:
	beq $t2,$zero,exit
	move $t0,$t1
	move $t1,$t2
	rem $t2,$t1,$t0
	jal loopo
exit: #readInt s
	
	li $v0,5
	syscall
	move $t3,$v0
	jal loopt
	
loopt:
	beq $t3,$t1,end
	li $v0,4
	la $a0,w1
	syscall
	li $v0,4
	la $a0,w2
	syscall
	li $v0,5
	syscall
	move $t3,$v0
	jal loopt
end: #print("Sygxaritiria")
	li $v0,4
	la $a0,c1
	syscall
	
	#exit 
	li $v0,10
	syscall
	
	.data
inta:  .word 0
intb:  .word 0
y:  .word 0
s:  .word 0
p1: .asciiz "Insert an integer. "
q1: .asciiz "What is the greatest common divisor of "
q2: .asciiz " and "
q3: .asciiz "?"
w1: .asciiz "Lathos apantisi"
w2: .asciiz "Poios einai o mkd?"
c1:  .asciiz "Sygxaritiria"