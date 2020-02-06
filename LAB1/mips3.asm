#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
 main :
     	addi $v0, $0, 4
        la $a0, ask_input
        syscall
	#Getting the first input
        addi $v0, $0, 5
        syscall
        
	addi $s0, $v0, 0
	#Getting the second input
	addi $v0, $0, 4
        la $a0, ask_input
        syscall
        addi $v0, $0, 5
        syscall
        
        addi $s1,$v0,0	#s1 hplds the n2 value
        add $s3,$s1,$0   #s3 holds the n2 value
        
        #t2 = division
        add $t2,$0,$0
        #t3 = remainder to be
        add $t3,$0,$0
        #t4 = remainder
        add $t4,$0,$0
        loop:
       		slt $t1,$s0,$s1
        	bne $t1,$0,done
        	add $s1,$s1,$s3
        	addi $t2,$t2,1
        	j loop
        
        done:
        mul $t3,$t2,$s3
        sub $t4,$s0,$t3
        # printing
        addi $v0, $0, 4
        la $a0, result
        syscall
        addi $v0,$0,1
        add $a0,$t4,$0   	#t4 printed value(remainder)
        syscall
        addi $v0, $0, 4
        la $a0, line
        syscall
        addi $v0,$0,1
        add $a0,$t2,$0		#t2 printed value is division
        syscall
#################################################
#					 	#
#     	 	data segment			#
#						#
#################################################

	.data
ask_input: .asciiz "Please submit an input\n"
result: .asciiz "Remainder and division\n"
line: .asciiz "	\n"
