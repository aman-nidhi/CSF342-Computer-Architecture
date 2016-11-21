# 
# 
#       "Dutch national flag problem"
#       Author: Aman Nidhi
#       Year: 2016
# 
# 
.data
	.align 2
	array:		.word 0 1 0 2 1 1 0 0 0 1 2 1 0
	size:		.word 13		# size of the array
	space:		.asciiz " "
	newline:	.asciiz "\n"

.text
.globl main
	main:
		jal print
								#
		li $v0, 4				# system call 
		la $a0, newline
		syscall         		# execute

		jal DNFsort
		
		jal print
		
		li $v0, 10
		syscall

	# x - are the untravesed values
	# t2 is the iter
	# t0				    t1= length
	#  0000011111xxxxxx22222
	#  	   ^     ^     ^
	# 	   s0    t2    s1
	#			
	DNFsort:
		la $t0, array
		lw $t1, size
		addi $t1, -1
		mul $t5, $t1, 4
		add  $s1, $t0, $t5
		add  $s0, $zero, $t0
		addi $t2, $t0, 0

		loop:
			bgt $t2, $s1, return
			lw $t6, ($t2)

			li $t5, 0
			beq $t6, $t5, swap0
			swap0_ret:

			li $t5, 2
			beq $t6, $t5, swap2
			swap2_ret:

			li $t5, 1
			beq $t6, $t5, inct2
			inct2_ret:
			j loop

	return:
		jr $ra

inct2:
	addi $t2, $t2, 4
	j inct2_ret

swap0:							# Function that swaps two ints in array
	lw $t3, ($t2)
	lw $t4, ($s0)
	
	sw $t3, ($s0)
	sw $t4, ($t2)
	addi $s0, $s0, 4
	addi $t2, $t2, 4
	j swap0_ret


swap2:							# Function that swaps two ints in array
	lw $t3, ($t2)
	lw $t4, ($s1)
	
	sw $t3, ($s1)
	sw $t4, ($t2)
	addi $s1, $s1, -4
	j swap2_ret




###       Printing
print:
    print_loop_prep:
        la  $t0, array
        lw  $t1, size
        li  $t2, 0
    print_loop:
        bge $t2, $t1, print_end
        li  $v0, 1
        lw  $a0, 0($t0)
        syscall
        li  $v0, 4
        la  $a0, space
        syscall
        addi    $t0, $t0, 4
        addi    $t2, $t2, 1
        j   print_loop
    print_end:
        li  $v0, 4
        la  $a0, newline
        syscall
        jr  $ra

