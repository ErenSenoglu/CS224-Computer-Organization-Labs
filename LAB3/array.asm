#################################
#					 	#
#		text segment		#
#						#
#################################
.text		
.globl __start
__start:
	jal readArray
	move $s0,$v0		#Holds the array pointer
	move $s1,$v1		#Holds the array size
	
	#move $s0,$a0		
	#move $s1,$a1		
	#jal print
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
	la $a0,ask_menu5
	syscall
				#Getting the choice input
	addi $v0,$0,5
	syscall
	#move $t7,$v0		#t7 holds the menu choice
	
	beq $v0,5,exit
	move $a0,$s0
	move $a1,$s1
	beq $v0,1,bubbleSort1
	beq $v0,2,thirdMinThirdMax1
	beq $v0,3,mode1
	beq $v0,4,print1
bubbleSort1:
	jal bubbleSort
	j menu
thirdMinThirdMax1:
	jal thirdMinThirdMax
	move $s6,$v0
	move $s7,$v1
	
	addi $v0,$0,4
	la $a0,minS
	syscall
	move $a0,$s6
	li $v0,1
	syscall
	la $a0,line
	li $v0,4
	syscall
	la $a0,maxS
	syscall
	move $a0,$s7
	li $v0,1
	syscall
	
	j menu
mode1:
	jal mode
	move $s7,$v0
	addi $v0,$0,4
	la $a0,modeS
	syscall
	move $a0,$s7
	li $v0,1
	syscall
	j menu
print1:
	jal print	
	j menu
	#jal mode
	#move $a0,$v0
	#li $v0,1
	#syscall
	
	#la $a0,line
	#li $v0,4
	#syscall
	
	#move $a0,$v1
	#li $v0,1
	#syscall
	
	#la $a0,line
	#li $v0,4
	#syscall	
	
	#move $a0,$s0
	#move $a1,$s1
	#jal print
	
exit:	li $v0 , 10
	syscall
#----------------------------------------------------------------------------#
bubbleSort:
	#Arranging stack
	addi    $sp,$sp,-8
        sw      $s0,0($sp)	
        sw      $s1,4($sp)
        #Arranging stack
	move $t0,$a0	#t0 is array pointer , t1 is array size	
	move $t1,$a1	
	li $t2,1	#t2 is pass integer
	beqz $t1,endB	#CHECK IF SIZE IS EQUAL TO ZERO
loopB1:	
	beq $t2,$t1,endB
	li $t3,0	#t3 is array index
	loopB2:
		sub $s6,$t1,$t2
		beq  $t3,$s6,endB2
		
		addi $t4,$t3,1		#t4 is next index
		mul  $t9,$t3,4
		add  $t5,$t0,$t9	#t5 is pointer
		lw   $t6,0($t5)		#t6 is array[index]
		
		mul  $t9,$t4,4
		add  $t5,$t0,$t9
		lw   $t7,0($t5)		#t7 is array[nextIndex]
		
		abs $s0,$t7
		abs $s1,$t6
		
		sltu $t8,$s0,$s1	# t8 = (t7 < t6)
		bnez $t8,noSwap
		
		sw $t6,0($t5)	
		sw $t7,-4($t5)
		
		noSwap:
		addi $t3,$t3,1
		j loopB2
  endB2:addi $t2,$t2,1  #Incrementing pass
	j loopB1
endB:
	#Arranging stack
	lw 	$s1,4($sp)
	lw	$s0,0($sp)
	addi	$sp,$sp,8
	#Arranging stack
  	move $v0,$t0
 	move $v1,$t1
 	jr $ra	
#----------------------------------------------------------------------------#
thirdMinThirdMax: 			
	#move $a0,$a0
	#move $a1,$a1
	
	addi $sp,$sp,-4
	sw  $ra,0($sp)		#Storing stack pointer
	
	jal bubbleSort
	
	addi $t0,$a0,8			#t0 holds the address of max3
	
	addi $t1,$a1,-3			#t1 is size-3
	mul $t1,$t1,4			
	add $t1,$a0,$t1				#Now t1 is the address of min3
	
	lw $v0,0($t0)
	lw $v1,0($t1)
	
	lw $ra,0($sp)
	addi $sp,$sp,4		#Restoring the stack pointer
	
	jr $ra
	
#----------------------------------------------------------------------------#
mode:
	addi $t1,$a1,-1			#a0 is array address a1 is array size, t1 is loc of array size -1
	mul $t1,$t1,4
	move $t2,$a0			#t2 is array pointer
	li $t5,0			#t5 is inc1
	li $t6,0			#t6 is inc2(max mode)	
	li $t0,0
loopM:	
	beq $t0,$t1,endM		#t0 is loop index
	move $t2,$a0
	add $t2,$t2,$t0
	lw $t3,0($t2)			#t3 = a[index]
	lw $t4,4($t2)			#t4 = a[index+1]
	bne $t3,$t4,noInc
	
	addi $t5,$t5,1			#Incrementing counter by one
	addi $t0,$t0,4
	j loopM
	
noInc: 	
	bge $t5,$t6,change
	li $t5,0
	addi $t0,$t0,4
	j loopM		
change: move $t6,$t5			# max mode is t6 again 	
	addi $t9,$t2,0			# holding max element index
	li   $t5,0
	addi $t0,$t0,4
	j loopM
endM:	
	bgt $t6,$t5,return
	addi $t9,$t2,4
return:	lw $v0,0($t9)			#t9 is mode
	jr $ra
	
#----------------------------------------------------------------------------#
readArray:
	la $a0,submit		#Printing out submit string
	li $v0,4
	syscall
	li $v0,5		#Reading input
	syscall	
	
	move $t1,$v0		#Holds size
	mul  $t2,$t1,4		#Holds size x4
	
	or $a0,$0,$t2		 #allocate enough space for input size
	li $v0, 9 		#syscall 9 (sbrk)
	syscall
	
	move $t3,$v0		#t3 permenantly holds address of beginning of array
	move $t4,$t3		#t4 is index
	li $t0,0
loop:
	beq $t0,$t1,end	
	la $a0,submit1		#Printing out submit string
	li $v0,4
	syscall
	li $v0,5		#Reading input
	syscall	
	sw  $v0,0($t4)
		
	addi $t4,$t4,4		#Incrementing index
	addi $t0,$t0,1
	j loop
	
end:
	move $v0,$t3
	move $v1,$t1
	jr $ra
#----------------------------------------------------------------------------#
print:
	move $t9,$a0
	move $t8,$a1
	
	beqz $a1,sizeZ				#a0 is array pointer , a1 is array size	
	move $t1,$a0
	li $t3,0
loop1:
	beq $t3,$a1,endP
	lw $t0,0($t1)				#Reading array.
	
	move $a0,$t0
	li $v0,1
	syscall					#Printing elements.
	addi $t1,$t1,4
	addi $t3,$t3,1				#Loop index 
	j loop1
	
endP:	
	li $v0,4
	la $a0,line
	syscall
	move $v0,$t9
	move $v1,$t8
	jr $ra
sizeZ:
	la $a0,sizeZero				#Prints size zero string.
	li $v0,4
	syscall
	jr $ra
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
submit: .asciiz "\nPlease submit array size."
submit1: .asciiz "\nPlease submit an input."
sizeZero: .asciiz "Array size is 0\n"
minS: .asciiz "Third minimum is: \n"
maxS: .asciiz "Third maximum is: \n"
modeS: .asciiz "Mode is: \n"
ask_menu1: .asciiz "\n1. Bubble Sort the array.\n"
ask_menu2: .asciiz "2.Find the third min and third max of the array.\n" 
ask_menu3: .asciiz "3. Find the most frequently appearing element of the array.\n"
ask_menu4: .asciiz "4. Display the array.\n"
ask_menu5: .asciiz "5. Quit.\n"
line: .asciiz "\n"
##
## end of program.
	
