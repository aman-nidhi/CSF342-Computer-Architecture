#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
	myInt:		.word 9999
	storeInt:	.word 0

.text
####################### INTEGER
# first supply appropriate values in registers $v0 and $a0-$a1
# result value (if any) returned in register $v0
# $v0 = 5 if read else 1 if print
	
	# user input. value stored in $v0
	li $v0, 5 
	syscall

	# pinting immidiate interger value
	li $v0, 1 
	li $a0, 777
	syscall

	# print from label defined in .data
	li $v0, 1 
	lw $a0, myInt
	syscall

	# storing value into RAM variable in .data
	li  $v0, 5          # 5 = read_int syscall.
	syscall 
	la $t0, storeInt
	lw $v0, ($t0)		# sotring the input value to a label(RAM)

	
# executing every instruction PC increases by 4 and if there is no instruction after the last 
# line the there will be segmentation fault if you dont exit your program.
	li $v0, 10
	syscall
	

