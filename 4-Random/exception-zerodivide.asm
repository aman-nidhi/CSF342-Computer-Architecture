

.text
.globl main
	main:	li $t1, 300
	li $t0, 0
	div $a0, $t1, $t0	# Do $a0 = $t1 / $t0

	li $v0, 1		# Print result as an integer
	syscall

	li $v0, 10		# and exit
	syscall
	
