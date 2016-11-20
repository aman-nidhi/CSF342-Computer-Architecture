# 	
# 
#           "Fobonacci"
#			Author: Aman Nidhi
# 			Year  : 2016
# 
# 
.data
	funct:		.asciiz "\nFibonacci\n"
	input:		.asciiz "Enter the upper limit# "
	newline:	.asciiz "\n# "

.globl main
.text
main:
	li $v0, 4			# promt what this program does
	la $a0, funct
	syscall

	li $v0, 4			# Prompt user to input value of the upper limit 
	la $a0, input
	syscall

	li $v0, 5			# upper limit
	syscall				
						# $t0: pre-previous
						# $t1: previous
						# $t2: next
	move $t3, $v0		# $t3: the upper limit
	
	li $v0, 4			# Print the first two numbers
	la $a0, newline
	syscall
	li $v0, 1
	li $a0, 1
	syscall				# print 1
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 1
	li $a0, 2			# print 2
	syscall
	
	li $t0, 1			# Initial values
	li $t1, 2

						# $t0: pre-previous
						# $t1: previous
						# $t2: next
						# $t3: the upper limit
		
loop:					# Compute Fibonacci numbers in this loop
	add $t2, $t0, $t1
	bgt $t2, $t3, loop_end
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	move $t0, $t1
	move $t1, $t2
	ble $t2, $t3, loop
		
loop_end:				# Terminate the program
	li $v0, 10
	syscall