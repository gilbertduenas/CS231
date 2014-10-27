	.data
array:	.space	80
str:		.asciiz	"Please enter an array size for 1 to 20 integers: "
str1:	.asciiz	"Please enter a positive integer divisible by 3: "
str2: 	.asciiz	"\n"
str3:	.asciiz	"\nError.... "
str4:	.asciiz	"\nThis is your array.\n"
str5:	.asciiz	"\n\nReversing array....\n"
str6:	.asciiz	"\n\nThank you."
	.text
main:
	li	$t0, 0		#initialize array counter to 0
	li	$t1, 1		#initialize user array size input to 0
	li	$t2, 0		#initialize user array element input to 0
	li	$t3, 20	#$t3 to check array size is less than or equal to 20
	li	$t4, 3		#check if user input is divisible by 3
	li	$t5, 1		#$t5 to check array size is greater than or equal to 1
		
	la $s0, array	#initialize array pointer to $s0
	la $s1, array	#initialize array pointer to $s1 for reversing
		
	jal readNum
	jal verifySize
		
	jal createArray
	jal printArray
	jal reverseArray 
	jal printArray
		
	j exit
		
#---------------------------------------------------------------------------------------------- 
readNum: 
		
	li $v0, 4		#print string command 4
	la $a0, str	#print str "Please enter an array size for 1 to 20 integers: "
	syscall
		
	li $v0, 5		#store user input in $v0
	syscall 
		
	add	$t1, $v0, $0 	#store user input in $t1
		
	jr $ra	
		
#----------------------------------------------------------------------------------------------
verifySize:	
	bgt $t1, $t3, errorSize		#check if $t1 is greater than 20
	blt $t1, $t5, errorSize		#check if $t1 is less than 1
		
	jr $ra
		
#----------------------------------------------------------------------------------------------
createArray: beq $t0, $t1, exitCreate 	#go to exit when $t0 = $t1	
		
	li $v0, 4		#print string command 4
	la $a0, str1	#print str "\nPlease enter a positive integer divisible by 3: "
	syscall
		
	li $v0, 5    	#store user input in $v0
	syscall 
		
	add $t2, $v0, $0 	#store user input in $t1
	div $t2, $t4 	#divide input $v0 by 3 
	mfhi $t5		#remainder
	mflo $t6		#quotient
	
	bne $t5, $0, errorDivide	#check if $t5 remainder is zero
	blt $t6, 1, errorDivide		#check if $t6 is positive
	
	sw $t2, 0($s0)   	#store word 0($s0) in $v0
		
	addi $s0, $s0, 4	#increment the pointer $s0. this is the array counter
	addi $t0, $t0, 1	#increment loop counter
		
	j  createArray		#Repeat createArray
		
exitCreate: jr $ra
		
#----------------------------------------------------------------------------------------------
printArray: 
	li $t0, 0				#initialize array counter to 0
	la $s0, array	#initialize pointer $s0 to 0
	
	li $v0, 4			#print string command 4
	la $a0, str4	#print str4 "\nThis is your array."
	syscall
	
	printLoop: beq $t0, $t1, exitPrint #go to exit when $t0 = $t1	

		lw $t2, 0($s0)	#get element from $s0 and store in $t2	

		li $v0, 4			#print string command 4
		la $a0, str2	#print str 2 "\n"
		syscall
		
		li $v0, 1					#print integer command 1
		add $a0, $t2, $0	#print the integer from $s0
		syscall
		
		addi $s0, $s0, 4	#increment the pointer $s0. 
		addi $t0, $t0, 1	#increment loop counter

		j printLoop
		
exitPrint: jr $ra

#----------------------------------------------------------------------------------------------
reverseArray:
	li $t0, 0				#initialize array counter to 0
	la $s0, array	#initialize pointer $s0 to 0
	la $s1,  array	#initialize point $s1 to 0
		
	addi $t7, $t7,  4	#set $st7 to 4 for use as byte multiplier
	mult $t1, $t7		#multiply increment by 4. example increment 5*4 = 20
	mfhi $t5	#decimal hi
	mflo $t6	#integer lo
	add $s1, $s1, $t6		#add 20 to the address of $s1
	sub $s1, $s1, 4			#subtract 4 from the address of $s1 to get the last index
	
	li $v0, 4			#print string command 4
	la $a0, str5	#print str5 "\nReversing array.... "
	syscall

	reverseLoop: bgt $s0, $s1, exitReverse 	#exit when $s0 is greater than $s1
		
		lw $t2, 0($s0)	#load the first element
		lw $t6, 0($s1)	#load the last element

		sw $t6, 0($s0)	#store word to swap positions
		sw $t2, 0($s1)	#store word to swap positions
	
		addi $s0, $s0, 4	#increment pointer $s0. this is the array counter
		sub $s1, $s1, 4		#decrement pointer $s1. this is the array counter

		j reverseLoop 	#repeat the loop
		
exitReverse: jr $ra

#----------------------------------------------------------------------------------------------
errorSize:
	li $v0, 4			#print string command 4
	la $a0, str3	#print str3 "Error...."
	syscall
	
	j main
	
#----------------------------------------------------------------------------------------------
errorDivide:	
	li $v0, 4			#print string command 4
	la $a0, str3	#print str3 "Error...."
	syscall
	
	j createArray
	
#----------------------------------------------------------------------------------------------
exit:
	li $v0, 4			#print string command 4
	la $a0, str6	#print str6 "\nThank you"
	syscall

	li $v0, 10	#exit the program
	syscall
