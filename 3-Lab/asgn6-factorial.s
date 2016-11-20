# 
# 
#           "Calculate Factorial of N"
#			Author: Aman Nidhi
# 			Year  : 2016
# 
# 
.data
	newline: 		.asciiz "\n"
	input_n: 		.asciiz "input number to compute Factorial:\n"
	factorial_ans: 	.asciiz "calculated value:\n"
	num:			.word 0
	ans: 			.word 0

.text
	main:
		li $v0, 4
		la $a0, input_n
		syscall
		

		li $v0, 5
		syscall
		sw $v0, num

		lw $a0, num
		jal fac_loop
		sw $v0, ans

		li $v0, 4
		la $a0, factorial_ans
		syscall

		lw $t0, ans
		add $a0, $t0, $zero
		li $v0, 1
		syscall

		li $v0, 10
		syscall

		# factorial loop
		fact_loop:
			addi $sp, $sp, -8
			sw $s0, 4($sp)
			sw $ra, 0($sp)

			li $v0, 1
			beq $a0, $zero, fact_end


			# factorial(n-1)
			move $s0, $a0
			addi $a0, $a0, -1
			jal fact_loop

			mul $v0, $s0, $v0

			fact_end:
				lw $s0, 4($sp)
				lw $ra, 0($sp)
				addi $sp, $sp, 8
				jr $ra



		
			



