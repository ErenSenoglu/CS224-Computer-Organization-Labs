#################################
#					 	#
#		text segment		#
#						#
#################################
.text		
.globl __start
__start:
	la $a0,ask1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0
	
	la $a0,ask1
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $s1,$v0
	
	la $a0,ask2
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $s2,$v0
	
	
	move $a0,$s0
	move $a1,$s1
	move $a2,$s2
	jal checkPattern
	move $s6,$v0
	
	la $a0,ask3
	li $v0,4
	syscall
	
	move $a0,$s6
	li $v0,1
	syscall
	
	li $v0,10
	syscall
checkPattern:
	li $t0,0		#t0 is loop index
	li $t4,32		# 						Assuming input size is 12
	div $t1,$t4,$a2
	#li $t1,5		#t1 is max (32/n)
	li $v0,0		#total count

loop:
	beq $t0,$t1,end
	move $s3,$a1
	li $t5,0
	li $t6,0
loop2:		
	beq $a2,$t5,end2
	srl $s3,$s3,1			#s3 is shifted left of a1
	addi $t5,$t5,1
	j loop2
end2:
loop3:
	beq $a2,$t6,end3
	sll $s3,$s3,1
	addi $t6,$t6,1
	j loop3
end3:	
	sub $s3,$a1,$s3			#Looking for last 3 index
	bne $s3,$a0,noC			#count if equal
	addi $v0,$v0,1
	
noC:
	li $t6,0
loop4:	
	beq $a2,$t6,end4
	srl $a1,$a1,1
	addi $t6,$t6,1
	j loop4
end4:	
	addi $t0,$t0,1
	j loop
end:
	jr $ra
	
#----------------------------------------------------------------------------#
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
line: .asciiz "\n"
ask1: .asciiz "Please submit a proper input.\n"
ask2: .asciiz "Please submit the size of first input.\n"
ask3: .asciiz "Number of occurences are: "
##
## end of program.
