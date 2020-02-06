
#################################################
#					 	#
#		text segment			#
#						#
#################################################

	.text		
 main :
     	addi $v0, $0, 4
        la $a0, ask_size
        syscall

        addi $v0, $0, 5
        syscall


        addi $t0, $v0, 0
        addi $t1,$0,0
        addi $t3,$0,0
    loop:
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
        la $a0, reverse
        syscall
    	add $t7,$0,$0
    loop3:
	slt $s6,$t4,$t7
	bne $s6,$0,done
	#    	beq $t7,$t4,done
    	lw $s1,array($t7)
    	lw $s2,array($t4)
    	sw $s2,array($t7)
    	sw $s1,array($t4)
    	addi $t4,$t4,-4
    	addi $t7,$t7,4
    	j loop3
   done: 	
  	addi $t4,$0,4     #resetting first index pointer
	loop4 :
        beq $t4,$s3,exit3
        addi $v0,$0,1
        lw $t5, array($t4)	#t4 is offset
        add $a0,$t5,$0   	#t5 printed value
        syscall
        addi $t4,$t4,4
        j loop4
    exit3:
    lw $t5, array($t4)	#t4 is offset
    add $a0,$t5,$0   	#t5 printed value
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
reverse: .asciiz "Reversing the array \n"

##


