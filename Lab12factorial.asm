 .data
str: .asciiz "\n\nEnter a number 1-13: "
str1: .asciiz "\nResult: "
str2: .asciiz "\nThe number is too high."
str3: .asciiz "\nThe number is too low."
 .text
main:
 li $t0, 0
 li $t1, 0
 li $t2, 0
 li $t3, 2
 li $t4, 13
 
 li $v0, 4
 la $a0, str
 syscall
 
 li $v0, 5
 syscall
 addi $t0, $v0, 0
 
 add $t1, $0, $t0
 add $t2, $0, $t0

ble $t0, $0, low 
blt $t0, $t3, exit
bgt $t0, $t4, high

loop: blt $t2, $t3, exit
 sub $t2, $t2, 1
 mult $t1, $t2
 mflo $t1
 
 j loop

high:
 li $v0, 4
 la $a0, str2
 syscall

 j main
 
low:
 li $v0, 4
 la $a0, str3
 syscall

 j main

exit:
 li $v0, 4
 la $a0, str1
 syscall
 
 li $v0, 1
 add $a0, $t1, $0
 syscall
 
 li $v0,10
 syscall
