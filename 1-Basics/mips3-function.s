#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
	message: .asciiz "hi, there\n my name is aman\n"

.text
	main:
		jal displayMessage

		addi $a1, 50
		addi $a0, 100
		jal addNumbers
		li $v0, 1
		add $a0, $zero, $v1
		syacall

	# this is mandatory for the recursion to stop
	li $v0, 10
	syscall

	displayMessage:
		li $v0, 4
		la $a0, message
		syscall
		jr $ra
		# jump to the address that called

	addNumbers:
		add $v1, $a1, $a0
		jr $ra
		# jump to the address that called


	
