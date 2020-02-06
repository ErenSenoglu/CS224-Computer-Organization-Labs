#################################
#					 	#
#		text segment		#
#						#
#################################
.text		
.globl __start
__start:
	# Asks user input
	
	la $a0,string1
	la $a1,string2
	jal reverseString
	la $a0,string1
	li $v0,4
	syscall
	
	la $a0,line
	li $v0,4
	syscall
	
	la $a0,string2
	li $v0,4
	syscall
	
	li $v0,10
	syscall
	
#--------------------------------------------------------------------------------#	
reverseString:
       		
       	#beq 	$a1, $0, end
       	lb      $t0, 0($a0)             # Load a character,
       	beq 	$t0, $0, end
       	#lb	$t1, 0($a1)
        #beq     $t0, $0, end        	# if it is null then return.
        #beq     $t0, 0x0000000a, end
         
        
        addi    $sp,$sp,-8		# Storing ra and t0
        sw      $ra,0($sp)
        sw	$t0,4($sp)
        #sw 	$t1,8($sp) 
        #sw	$a0,16($sp)
        #sw 	$a1,12($sp)     
        
        addi 	$a0, $a0,1		# Incrementing index by 1
        #addi 	$a1, $a1,1		# Incrementing index by 1                                                       	
        jal reverseString
        
	lw	$ra,0($sp)
	lw	$t0,4($sp)
	#lw	$t1,4($sp)
	addi	$sp,$sp,8
	
	sb $t0,0($a1)
	addi $a1,$a1,1
end:	        
	jr $ra
#---------x-------------------------------------------------------------------#
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
string1:  .asciiz  "abc"
string2: .asciiz "123"
line: .asciiz "\n"
##
## end of program.
