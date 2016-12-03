

.text
.globl main
	main:	
		la $t0, 0x00000000		# Load a memory address where there is no memory
		lw $a0, ($t0)			# Try to load a value at that location

		li $v0, 10				# Exit
		syscall

