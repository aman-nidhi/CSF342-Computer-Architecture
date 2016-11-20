# 
# 
#           "Calculate String Length"
#			Author: Aman Nidhi
# 			Year  : 2016
# 
# 
.data
	theStr: 		.space 	1000
	size: 			.word 	1000
	newline: 		.asciiz "\n"
	input: 			.asciiz "\nEnter string with max 1000 characters: "
	output:			.asciiz "\nLength of the String is: "

.text
	main:
		li $v0, 4			# prompt user to input string
		la $a0, input
		syscall
		
		li $v0, 8			# get string
		la $a0, theStr
		lw $a1, size
		syscall

		la $t0, theStr    	# first address
		lb $t4, newline

		str_len:
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

		li $v0, 4
		la $a0, output
		syscall

		li $v0, 1
		sub $t5, $t0, $t1
		addi $a0, $t5, 1
		syscall

	exit:
		li $v0, 10
		syscall



		
