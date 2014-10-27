	.data
array: 	.space 100
str:	.asciiz "\nPlease enter a number to calculate factorial: "
str:	.asciiz "\nThe factorial is: "
	.text
main:
	li $s0, 0 #Array counter
	li $s1, 1 #constant to check against user input 
	
	
	la $s, array #initialize array point to $s1