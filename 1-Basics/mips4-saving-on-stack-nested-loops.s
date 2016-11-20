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
		jal printNewLine		
		jal printValue
		j exit

	updateRegister:
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $ra, 4($sp)

		addi $s0, $s0, 30
		# s0 become 40

		#print new value in function
		# {li $v0, 1
		# move $a0, $s0
		# syscall}
		jal printValue
		# nested procedure, must the return address of the caller-updateRegister

		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 4

		jr $ra
	
	printValue:
		li $v0, 1
		move $a0, $s0
		syscall
		jr $ra

	printNewLine:
		addi $v0, 4
		la $a0, newLine
		syscall
		jr $ra

# executing every instruction PC increases by 4 and if there is no instruction after the last 
# line the there will be segmentation fault if you dont exit your program.
exit:
	li $v0, 10
	syscall