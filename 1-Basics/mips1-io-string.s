#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
	# The directive .asciiz creates a null-terminated character string.
	myMsg:  .asciiz "input your name\n" 
	greeting: .asciiz "Hello: "
	name:   .space 20  
	# name is variable like an array with 20 bytes in size
	

.text

####################### STRING
# $a0 store the address of the string or the character value and not the string itself
# $v0 = 4 if print else 8 if read
# reading string::
# 		$a0 = memory address of string input buffer
#		$a1 = length of string buffer (n)

	# getting string from user and printing it
	li $v0, 4
	la $a0, myMsg
	syscall
	li $v0, 8
	la $a0, name
	li $a1, 20 #buffer length
	syscall
	li $v0, 4
	la $a0, greeting
	syscall
	la $a0, name
	syscall

	

	


# executing every instruction PC increases by 4 and if there is no instruction after the last 
# line the there will be segmentation fault if you dont exit your program.
	li $v0, 10
	syscall
	

