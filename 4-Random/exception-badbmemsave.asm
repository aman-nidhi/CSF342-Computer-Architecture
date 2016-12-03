

.text
.globl main
	main:	
		la $t0, 0x00000000	# Load a memory address where there is no memory
		sw $a0, ($t0)		# Try to save a value at that location

		li $v0, 10			# Exit
		syscall
