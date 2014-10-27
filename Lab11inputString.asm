	.data
message: 		.space 20
encrypt:	.space 20
decrypt:	.space 20
str:	.asciiz "\n"
str1:	.asciiz "\nEncryption: "
str2:	.asciiz "\nDecryption:  " 
	.text
main:
	la $s0, message
	la $s1, encrypt
	la $s2, decrypt
	
	li $t0, 20
	li $t3, 10		#key for encrypt/decrypt

	li $v0, 8
	la $a0, message
	li $a1, 20
	syscall
	
loopEncrypt: beq $t0, $0, print
	lb $t1, 0($s0)
	xor $t2, $t1, $t3
	sb $t2, 0($s1)
	li $t1, 0
	li $t2, 0
	addi $s1, $s1, 1
	addi $s0, $s0, 1
	sub $t0,$t0, 1
	j loopEncrypt
	
print:
 	li $v0, 4
	la $a0, str1 #Encryption
	syscall
	
	li $v0, 4
	la $a0, encrypt
	syscall

	li $v0, 4
	la $a0, str
	syscall

	li $t0, 20
	la $s1, encrypt
	
loopDecrypt: beq $t0, $0, print2
	lb $t1, 0($s1)
	xor $t2, $t1, $t3
	sb $t2, 0($s2)
	li $t1, 0
	li $t2, 0
	addi $s2, $s2, 1
	addi $s1, $s1, 1
	sub $t0,$t0, 1
	j loopDecrypt

print2: li $v0, 4
	la $a0, str2 #Decryption
	syscall

	li $v0, 4
	la $a0, decrypt
	syscall

	li	$v0, 10 		#exit the program
	syscall