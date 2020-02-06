#################################
#					 	#
#		text segment		#
#						#
#################################
.text		
.globl __start
__start:
	# Asks user input
	la $a0,ask1
	li $v0,4
	syscall
	
	#Gets the input
	la $a0,string
	li $a1,8
	li $v0,8
	syscall
	
	jal convertToInt
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
#--------------------------------------------------------------------------------#	
convertToInt:
       	lb      $t0, 0($a0)             # Load a character,
        beq     $t0, $0, end        	# if it is null then return.
        beq     $t0, 0x0000000a, end
        
        
        addi    $t1, $t0, -48		# Converting to int , t3 is our total sum
        add 	$t3,$t3,$t1
        addi 	$a0, $a0,1		# Incrementing index by 1
        addi    $sp,$sp,-4		# Storing ra
        sw      $ra,0($sp)	
        jal convertToInt
        
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	move 	$v0,$t3
end:
	        
	jr $ra
#----------------------------------------------------------------------------#
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
string: .space 8
line: .asciiz "\n"
ask1: .asciiz "Please submit a proper input.\n"
##
## end of program.
