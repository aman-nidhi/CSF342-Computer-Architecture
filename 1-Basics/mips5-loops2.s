#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data               
    msg:            .asciiz "loop example, defined as a funtion\n"
    prompt:         .asciiz "Enter an upper bound: "
    newline:        .asciiz "\n"

.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $a0, $v0           # upper bound in a0

    jal def_loop
    j exit

# this is just a basic loop example which shows an unothodox way to write loop in mips
# basically it prints 0 to upper-bound-1
# 
def_loop:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sub $s0, $s0, $s0        # $s0 = 0, (counter) init
    move $s1, $a0            # store the argument into $s1(upper bound)

loop_main:
    beq $s0, $s1, loop_exit  # if counter==input then exit loop
    move $a0, $s0            # print the int
    li $v0, 1
    syscall

    li $v0, 4               # print newline after int
    la $a0, newline
    syscall

    addi $s0, $s0, 1        # increment counter
    j loop_main

loop_exit:
# Restore the original stack
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# exit program
# 
exit:
    li $v0, 10
    syscall
