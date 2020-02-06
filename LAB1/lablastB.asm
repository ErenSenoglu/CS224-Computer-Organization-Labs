#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:		# execution starts here
	addi $v0,$0,4	# Getting the array size input
	la $a0, ask_size
	syscall
	
	addi $v0,$0,5
	syscall
	
	addi $t0, $v0, 0 #t0 holds the array size
	move $t1,$0	#t1 is array index
	mul $t3, $t0, 4 #t3 holds the size x4
loop:	
	
	beq $t1, $t3, done #checking if array is full
	
	addi $v0,$0,4
        la $a0,ask_input
        syscall

        addi $v0,$0,5
        syscall
        addi $t2, $v0, 0	#t2 is input value

        sw $t2, array($t1) 
        addi $t1,$t1,4
        
	j loop
done:

menu: 
	addi $v0,$0,4
	la $a0,ask_menu1	#Printing out the choices
	syscall
	la $a0,ask_menu2
	syscall
	la $a0,ask_menu3
	syscall
	la $a0,ask_menu4
	syscall
				#Getting the choice input
	addi $v0,$0,5
	syscall
	#move $t7,$v0		#t7 holds the menu choice
	
	beq $v0,4,exit
	beq $v0,1,less
	beq $v0,2,interval
	beq $v0,3,occurence
less:	
	li $v0,4
	la $a0,ask_int
	syscall
	li $v0,5
	syscall
	move $a3,$v0
	jal lfunction
	move $a0,$v0
	li $v0,1
	syscall
	j menu
	 
interval:
	li $v0,4
	la $a0,ask_intl
	syscall
	li $v0,5
	syscall
	move $a2,$v0  		#input of larger value
	li $v0,4
	la $a0,ask_ints
	syscall
	li $v0,5
	syscall
	move $a3,$v0 		#input of smaller value
	jal ifunction
	move $a0,$v0
	li $v0,1
	syscall
	j menu
	 
occurence:
	li $v0,4
	la $a0,ask_int
	syscall
	li $v0,5
	syscall
	move $a1,$v0 
	jal ofunction
	move $a0,$v0
	li $v0,1
	syscall
	j menu	
exit:   addi $v0,$0,10
	syscall	
	
#------------------------------------------------
lfunction: 
	   mul $t4,$t0,4 	#t4 holds size x4
	   add $t5,$0,$0	#t5 is index value
	   add $s1,$0,$0 	#s1 holds the summation
	   
loop2:	beq $t4,$t5,done2	#Loop condition
	lw $s2,array($t5)
	 
	slt $t6,$s2,$a3		#Checking if value is lt input
	beq  $t6,$0,iterate
	
	add $s1,$s1,$s2		#Summation
	
iterate:addi $t5,$t5,4		#Iteration
	j loop2
done2:  move $v0,$s1
	jr $ra
#------------------------------------------------
ifunction:
	mul $t4,$t0,4 	#t4 holds size x4
	add $t5,$0,$0	#t5 is index value
	add $s1,$0,$0 	#s1 holds the summation
	
loop3:	beq $t4,$t5,done3	#Loop condition
	lw $s2,array($t5)
	
	slt $t6,$s2,$a2		#Checking if value is lt input
	
	slt $t7,$a3,$s2		#Checking if value is gt input 2
	
	and $t7,$t7,$t6
	
	beq  $t7,$0,iterate3
	
	add $s1,$s1,$s2		#Summation
	
iterate3:addi $t5,$t5,4		#Iteration
	j loop3
done3:  move $v0,$s1
	jr $ra
#------------------------------------------------
ofunction:
	mul $t4,$t0,4 	#t4 holds size x4
	add $t5,$0,$0	#t5 is index value
	add $s1,$0,$0 	#s1 holds the summation
	
loop4:	beq $t4,$t5,done2	#Loop condition
	lw $s2,array($t5)
	 
	rem $t6,$s2,$a1		#Checking if value is lt input
	bne $t6,$0,iterate4
	
	addi $s1,$s1,1		#Summation
	
iterate4:addi $t5,$t5,4		#Iteration
	j loop4
done4:  move $v0,$s1
	jr $ra
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
array: .space 400	
endl:	.asciiz "\n"
ask_menu1: .asciiz "\n1. Find summation of numbers stored in the array which is less than an input number.\n"
ask_menu2: .asciiz "2. Find summation of numbers out of a value range\n" 
ask_menu3: .asciiz "3. Display the number of occurrences of the array elements divisible by a certain input number.\n"
ask_menu4: .asciiz "4.Quit\n"
ask_int: .asciiz "Submit an integer \n"
ask_intl: .asciiz "Submit the larger integer \n"
ask_ints: .asciiz "Submit the smaller integer \n"
ask_input: .asciiz "Submit an input to store \n"
ask_size: .asciiz "Submit the array size \n"
##
## end of Program3.asm
