#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
 main :
 	#Gets array size 
     	addi $v0, $0, 4
        la $a0, ask_size
        syscall

        addi $v0, $0, 5
        syscall


        addi $t0, $v0, 0
        addi $t1,$0,0
        addi $t3,$0,0
    loop:
    	#Gets array inputs
        beq $t0,$t1,exit

        addi $v0,$0,4
        la $a0,ask_input
        syscall

        addi $v0,$0,5
        syscall
        addi $t2, $v0, 0

        sw $t2, array($t3)   # input is t2
	#la $t4,array
	#t3 is last object pointer(size*4)
        addi $t3,$t3,4
        addi $t1,$t1,1
	addi $s3,$t3,0 #t3 holds the last index pointer
        j loop
    exit:

    loop2 :
    	# Print outs the array contents
        beq $t4,$t3,exit2
        addi $v0,$0,1
        lw $t5, array($t4)	#t4 is offset
        add $a0,$t5,$0   	#t5 printed value
        syscall
        addi $t4,$t4,4
        j loop2
    exit2:
    	#add $t4,$0,$0
    	addi $v0, $0, 4
        la $a0, palindrome
        syscall
    	add $t7,$0,$0
    	addi $t4,$t4,-4
    	#Palindrome checking
    loop3:
	slt $s6,$t4,$t7
	bne $s6,$0,done
	#    	beq $t7,$t4,done
    	lw $s1,array($t7)
    	lw $s2,array($t4)
    	bne $s1,$s2,notPal
    	#sw $s2,array($t7)
    	#sw $s1,array($t4)
    	addi $t4,$t4,-4
    	addi $t7,$t7,4
    	j loop3
   done: 	
   	la $a0,Pali	# put string address into a0
	li $v0,4	# system call to print
	syscall	
   	li $v0,10
	syscall	
   notPal:
   	la $a0,notPali	# put string address into a0
	li $v0,4	# system call to print
	syscall	
   	li $v0,10
	syscall	
#################################################
#					 	#
#     	 	data segment			#
#						#
#################################################

	.data
array: .space 80
ask_size: .asciiz "Please submit a size\n"
ask_input: .asciiz "Please submit an input\n"
palindrome: .asciiz "Checking the palindrome \n"
notPali: .asciiz "Array is not a palindrome \n"
Pali: .asciiz "Array is a palindrome \n"

##

   
