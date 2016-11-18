# 
# 
#           "Check if string Is Palindrome"
#			Author: Aman Nidhi
# 			Year  : 2016
# 
# 
.data
	theStr: 	.space 100
	size: 		.word 0
	newline: 	.asciiz "\n"
	true: 		.asciiz "Is palindrome"
	false: 		.asciiz "Not palindrome"
	input: 		.asciiz "input string:\n"
	input_size: .asciiz "input size:\n"

.text
	main:
		li $v0, 4		
		la $a0, input_size
		syscall

		li $v0, 5
		syscall
		sw $v0, size

		li $v0, 4
		la $a0, input
		syscall
		
		li $v0, 8
		la $a0, theStr
		lw $a1, size
		syscall

		la $t0, theStr    	# first address
		lb $t4, newline

		str_len:			# string length	
			lb $t1, ($t0)
			addi $t0, $t0, 1
			beq $t1, $t4, next
			bne $t1, $zero, str_len

		next:
			addi $t0, $t0, -2
			add $t1,$a0,$zero

		li $v0, 4
		la $a0, newline
		syscall

		main_loop:					# t1 the first, t0 has the last address
			bge $t1, $t0, isPalin	# while t1 < t0
			lb $t2, 0($t0)
			lb $t3, 0($t1)
			bne $t2, $t3, notPalin
			addi $t1, $t1, 1
			addi $t0, $t0, -1
			j main_loop

		isPalin:
			li $v0, 4
			la $a0, true
			syscall
			j exit
		notPalin:
			li $v0, 4
			la $a0, false
			syscall	

		exit:
			li $v0, 10
			syscall



		
