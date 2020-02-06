#################################
#					 	#
#		text segment		#
#						#
#################################
.text		
.globl __start
__start:
	#la $a0,example
	#jal convertToDec
	#move $a0,$v0		#printing out the result
	#li $v0,1
	#syscall
	jal interactWithUser
	
	
	li $v0,10
	syscall
	
#--------------------------------------------------------------------------------#	
convertToDec:
        li      $v0, 0                  # v0 is accumulator.
        addi    $sp,$sp,-8
        sw      $s0,0($sp)	
        sw      $s1,4($sp)
loop:
        lb      $s0, 0($a0)             # Load a character,
        beq     $s0, $0, end        	# if it is null then return.
        beq     $s0, 0x0000000a, end  
        mul     $v0, $v0, 8		# Multiplying accumulator by 8         
        addi    $s1, $s0, -48           # Calculating the value of the character.
        add     $v0, $v0, $s1          
        addi    $a0, $a0, 1             # Incrementing the pointer
        j       loop                    # Jumping back to loop.

end:
	lw 	$s1,4($sp)
	lw	$s0,0($sp)
	addi	$sp,$sp,8
	jr $ra
#----------------------------------------------------------------------------#
interactWithUser:

	la $a0,octal
	li $a1,8
	li $v0,8
	syscall
	#(s0,t1,)
	addi    $sp,$sp,-8		#Storing s0 and s1 in memory.
        sw      $s0,0($sp)	
        sw      $s1,4($sp)
        
	
loop1:
	lb    $s0, 0($a0)               # Load a character,
	beq   $a0, $a1,end1		# end of character array.
	sltiu $s1, $s0, 11 		# s1 = (x < 96) ? 1 : 0
    	bnez  $s1, end1
	beq   $s0,$zero,end1
        sltiu $s1, $s0, 48 		# s1 = (x < 48) ? 1 : 0
    	bnez  $s1, fail
    	sltiu $s1, $s0, 56 		# s1 = (x < 56) ? 1 : 0
    	beqz  $s1, fail
        addi  $a0, $a0, 1               # Finally, increment the pointer
        j       loop1                   # and loop.

end1:	
	#its a proper input
	la $a0,octal

	addi $sp,$sp,-4
	sw  $ra,0($sp)
	
	jal convertToDec	# calling another func to calculate
	
	move $a0,$v0		#printing out the result
	li $v0,1
	syscall
	
	move $v0,$a0
	
	lw $ra,0($sp)		#Getting back the old stack pointer.
	addi $sp,$sp,4
	
	
	lw 	$s1,4($sp)
	lw	$s0,0($sp)
	addi	$sp,$sp,8
	jr $ra
	
fail:
	#Not a proper input
	la $a0,error
	li $v0,4
	syscall
	
	lw 	$s1,4($sp)
	lw	$s0,0($sp)
	addi	$sp,$sp,8
	jr $ra
#--------------------------------------------------------------------------------#	
	
	

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
example: .asciiz "145"
octal: .space 8
error: .asciiz "Please submit a proper input."
##
## end of program.
