#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
	number1: .word 10
	number2: .word 35

.text
	lw $t0, number1($zero)
	lw $t1, number2($zero)
	add $t2, $t1, $t0
	li $v0, 1
	add $a0, $t2, $zero
	syscall

# executing every instruction PC increases by 4 and if there is no instruction after the last 
# line the there will be segmentation fault if you dont exit your program.
	li $v0, 10
	syscall

