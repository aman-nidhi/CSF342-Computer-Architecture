#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
	newLine: .asciiz "\n"

.text
	main:
		# convention to save s-register to stack not callee safe
		# generally before calling a fucntion
		addi $s0, $zero, 10

		jal updateRegister
		
		# print a new line 
		addi $v0, 4
		la $a0, newLine
		syscall

		li $v0, 1
		move $a0, $s0
		syscall
		j exit

	updateRegister:
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		addi $s0, $s0, 30
		# s0 become 40
		#print new value in function
		li $v0, 1
		move $a0, $s0
		syscall

		lw $s0, 0($sp)
		addi $sp, $sp, 4

		jr $ra
	
# executing every instruction PC increases by 4 and if there is no instruction after the last 
# line the there will be segmentation fault if you dont exit your program.
exit:
	li $v0, 10
	syscall