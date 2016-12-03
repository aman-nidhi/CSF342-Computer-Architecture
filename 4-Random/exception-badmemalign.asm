# Example program which causes an exception

.data
	X:	.word	7

.text
.globl main
	main:	
		la $t0, X			# Load X's address into $t0
		li $a0, 45		
		sw $a0, ($t0)		# Store 45 into X, this should work

		addi $t0, $t0, 1	# Misalign $t0 by 1 byte
		sw $a0, ($t0)		# Store 45 into X, this should fail

		li $v0, 10			# Exit
		syscall
