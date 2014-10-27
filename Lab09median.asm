	.data
array:	.space 200
str:	.asciiz "\n============================================================"	
str1:	.asciiz	"\nHow many numbers would you like to enter: " 
str2:	.asciiz	"\nEnter number "
str3:	.asciiz	": "
str4:	.asciiz "\nThe median is: "
	.text
main:
	li $s1, 0 #how many numbers to enter
	li $s2, 0 #counter for numbers entered
	li $s3, 0 #next number entered
	li $s4, 0 #final result
		
	la $s5, array	#$s5 points to first location of array with address array
	
	li $s6, 2 #divisor for median
	
	li $s7, 0	#to calculate median for even numbers entered
	li $t8, 1	#to calculate median for odd numbers entered
	li $t9, 4	#pointer incrememt
	
	li $t4, 0 	#initialize value 
	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall

jal input

	
	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall
	
jal median
	
	li		$v0, 4		#print string command 4
	la		$a0, str4	#print str4 "The median is "
	syscall	
	
	li		$v0, 1		#print integer command 1
	add		$a0, $v1, $0	#show median
	syscall	
	
	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall

j done

#input---------------------------------

input: 

	li		$v0, 4		#print string command 4
	la		$a0, str1	#print str1 "\nHow many number would you like to enter:"
	syscall	
	
	li 		$v0, 5		#store user input in $v0
	syscall	
	
	add 	$s1, $0, $v0	#store input in $s1

	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall
	
	inputLoop: beq $s2, $s1, exitInput	#exit input loop when $s1 and $s2 are equal
		addi 	$s2, $s2, 1	#counter for input loop
		
		li		$v0, 4		#print string command 4
		la		$a0, str2	#print str2 "Enter number "
		syscall	
		
		li		$v0, 1		#print integer command 1
		add		$a0, $s2, $0	#a0 is the storage for s0 + 0 then show counter		
		syscall

		li		$v0, 4		#print string command 4
		la		$a0, str3	#print str3 ": "
		syscall	
		
		li 		$v0, 5		#store user input in $v0
		syscall	
		
		sw 		$v0, 0($s5)	#store word 0($s5) in $v0
		addi 	$s5, $s5, 4	#increment the pointer $s5. this is the array counter
		
		

		j inputLoop
		
exitInput:	jr $ra

############## MEDIAN SUBROUTINE
median:
	la $s5, array	#$s5 points to first location of array with address array

	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall	
	
	div		$s1, $s6	#divide $s1 by $s6   5/2
	
	mfhi	$t1			#store the remainder  1
	mflo	$t2			#store the quotient	  2
	
	beq	$t1, 0, median1	#even numbers entered  1 != 0
	
	mult $t9, $t2   #4 *  2
	mflo $t3		#8	
	
	add $s5, $t3, $s5
	
	lw $t4, 0($s5)
	
	add $v1, $t4, $0

	jr $ra
	
median1:  #even 
	mult $t9, $t2
	mflo $t3
	
	add $s5, $t3, $s5
	
	lw $t3, 0($s5)

	sub $s5, $s5, $t9	
	
	lw $t4, 0($s5)
	
	add $t5, $t4, $t3
	
	div $t5, $s6
	
	mflo	$t2			#store the quotient	  2
	
	add $v1, $t2, $0
	
	jr $ra	
	
median2:	

############## END MEDIAN SUBROUTINE

done:	
	li	$v0, 10 		#exit the program
	syscall