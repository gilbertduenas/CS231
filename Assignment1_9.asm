	.data
first_loc:	.word 45,67
second_loc:	.word 78,90
temp_loc:	.word 0,0
str:		.asciiz	"first_loc"
str1:		.asciiz	"second_loc"
str2:		.asciiz	"\n"
	.text
main:
	li	$t0, 0							#$t0 is the counter from 0 to 5
	li	$t1, 5	   						# $t1 indicates there are 5 numbers in the array
	la	$t2, first_loc					#$t2 points to first location of array with address of first_loc
	la	$t3, second_loc				#$t3 points to first location of array with address of second_loc

loop:	beq	$t0, $t1, exit  	#when the loop is done jump to exit
	lw	$s0, 0($t2)					#store the next element of the array into $s0
	lw $s1, 0($t3)					#store the next element of the array into $s1
	
	li	$v0, 4		#print "first_loc:"
	la	$a0, str
	syscall

	li	$v0, 1			# output the content of one element of array
	add	$a0,$0,$s0
	syscall

	li	$v0, 4		#print "second_loc:"
	la	$a0, str1
	syscall
	
	li	$v0, 1			# output the content of one element of array
	add	$a0,$0,$s1
	syscall
	
	li	$v0, 4		# go to next line
	la	$a0, str2
	syscall

exit:
	li	$v0, 10
	syscall