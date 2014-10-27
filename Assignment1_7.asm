# This program swaps the location of numbers in an array and outputs the result to the screen.

	.data
first_loc:	.word	45, 67		# first array with two elements
second_loc:	.word	78, 90		# second array with two elements
temp_loc:	.word	0, 0		# temporary array for swapping elements
str:	.asciiz "\n"
str1:	.asciiz	"("
str2:	.asciiz	") : "
str3:	.asciiz "before execution\n\n"
str4:	.asciiz "\nafter execution"
str5:	.asciiz "\t"
	.text

main:	
	li	$t0, 0	   			# $t0 is the counter. 
	li	$t1, 2				# $t1 is the number of loops
	la	$s0, first_loc		# $s0 points to first location of array with address first_loc
	la	$s1, second_loc		# $s1 points to first location of array with address second_loc
	la	$s2, temp_loc		# $s2 points to first location of array with address temp_loc
	
loop:	beq	$t0, $t1, newLine		# when the loop is done jump to exit
	add	$t0, $t0, 1					# increment counter $t0 by 1

	lw	$t2, 0($s0)			# store the next element of the array into $t2
	lw	$t3, 0($s1)			# store the next element of the array into $t3
	lw	$t4, 0($s2)			# store the next element of the array into $t4
	
	li	$v0, 4				# print string command 4
	la	$a0, str1			# print str1 "(" 
	syscall

	li	$v0,1				# print integer command 1
	add	$a0,$0,$s0			# output the ADDRESS of an element of array first_loc
	syscall
	
	li	$v0, 4				# print string commnad 4
	la	$a0, str2			# print "): "
	syscall
	
	li	$v0,1				# print integer command 1
	add	$a0,$0,$t2			# output the CONTENTS of an element of array first_loc
	syscall

	li	$v0, 4				# print string command 4
	la	$a0, str5			# print "\t"
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str1			# print "("
	syscall

	li	$v0,1				# print integer command 1 
	add	$a0,$0,$s1			# output the ADDRESS of an element of array second_loc
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str2			# print "): "
	syscall
	
	li	$v0,1				# print integer command 1
	add	$a0,$0,$t3			# output the CONTENTS of an element of array second_loc
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str			# print "\n"
	syscall

	add	$t4, $t2, $t4		# copy contents from first_loc $t2 to temp_loc $t4
	sw	$t4, 0($s2) 		# store contents in array $t4 at address $s2
	
	add 	$t2, $0, $t3	# then copy contents from second_loc $t3 to first_loc $t2
	sw 	$t2, 0($s1)			# store contents in array $t2 at address $s1

	add 	$t3, $0, $t4	# then copy contents from temp_loc $t4 to second_loc $t3
	sw 	$t3, 0($s0)			# store contents in array $t3 at address $s0

	add	$s0, $s0, 4			# increment $s0 (the array pointer) by 4 to point to the next position
	add	$s1, $s1, 4			# increment $s1 (the array pointer) by 4 to point to the next position
	add	$s2, $s2, 4			# increment $s2 (the array pointer) by 4 to point to the next position

	j	loop				# repeat loop: loop	

newLine:					# add a new line, print str3, and reset counter $t0 to 0
	li	$v0, 4				# print command 4 
	la	$a0, str			# print "\n"
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str3			# print "before execution"
	syscall
	
	sub	$t0, $t0, 2			# decrement counter $t0 by 2

print:	beq	$t0, $t1, exit	# when the loop is done jump to exit
	add	$t0, $t0, 1			# increment counter $t0 by 1
	
	lw	$t2, 0($s0)			# store the next element of the array into $t2
	lw	$t3, 0($s1)			# store the next element of the array into $t3

	li	$v0, 4				# print string command 4
	la	$a0, str1			# print "("
	syscall

	li	$v0,1				# print string command 4
	add	$a0,$0,$s0			# output the ADDRESS of an element of array first_loc
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str2			# print "): "
	syscall
	
	li	$v0,1				# print string command 4
	add	$a0,$0,$t2			# output the CONTENTS of one element of array first_loc
	syscall

	li	$v0, 4				# print string command 4
	la	$a0, str5			# print "\t"
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str1			# print "("
	syscall

	li	$v0,1				# print integer command 1
	add	$a0,$0,$s0			# output the ADDRESS of an element of array first_loc
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str2			# print "): "
	syscall
	
	li	$v0,1				# print string command 4
	add	$a0,$0,$t3			# output the content of one element of array second_loc
	syscall
	
	li	$v0, 4				# print string command 4
	la	$a0, str			# print "\n"
	syscall
	
	add	$s0, $s0, 4			# increment $t2 (the array pointer) by 4 to point to the next position
	add	$s1, $s1, 4			# increment $t3 (the array pointer) by 4 to point to the next position
	
	j print					# repeat print: loop
	
exit:	
	li	$v0, 4				# print string command 4
	la	$a0, str4			# print "before execution"
	syscall

	li	$v0, 10				# load exit command 10
	syscall