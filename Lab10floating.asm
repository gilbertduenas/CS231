	.data
num95:	.float 1.8		#declare float 1.8
num32:	.float 32.0		#declare float 32.0
str:	.asciiz "\n============================================================"
str1:	.asciiz "\nPlease input a temperature in Celsius:\t\t "
str2:	.asciiz "\nThe temperature in Fahrenheit is:  =>\t\t "
	.text
main:
	l.s $f2, num95		#load single precision into  $f2
	l.s $f3, num32		#load single precision into  $f3

	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall
	
	li		$v0, 4		#print string command 4
	la		$a0, str1	#print str1 "Please input a temperature in Celsius: "
	syscall	
	
	li $v0, 5			#get user input
	syscall
	
	mtc1 $v0, $f1 		#move $v0 to coprocessor $f1
	cvt.s.w $f1, $f1 	#convert user input to float
	
	mul.s $f4, $f2, $f1	#multipy single precision
	add.s $f4, $f4, $f3	#add single precision
	
	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall	

	li		$v0, 4		#print string command 4
	la		$a0, str2	#print str2 "Enter number "
	syscall		
	
	li		$v0, 2		#print float command 1
	mov.s $f12, $f4		#move single precision into #$f12 for printing
	syscall	

	li		$v0, 4		#print string command 4
	la		$a0, str	#print str "\n============================================================"
	syscall
	
	li	$v0, 10 		#exit the program
	syscall