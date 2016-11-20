#   
#           "GCD Recusive O(Log min(a, b))"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    str_prompt: .asciiz   "GCD funtion\n"
    str_a:      .asciiz   "Enter the value of a:\n"
    str_b:      .asciiz   "Enter the value of b:\n"
    str_ans:    .asciiz   "gcd is:\n"

.text
main:
    li $v0, 4
    la $a0, str_prompt

    li $v0, 4
    la $a0, str_a
    syscall
    li $v0, 5
    syscall
    move $s0, $v0        # input a

    li $v0, 4
    la $a0, str_b
    syscall
    li $v0, 5
    syscall
    move $s1, $v0        # input b

    la $a0, str_ans
    li $v0, 4
    syscall
    move $s2, $sp
    move $s3, $ra

    move $a0, $s0
    move $a1, $s1

    jal def_GCD         # function call
    li $v0, 1
    syscall

    j exit

def_GCD:	
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    beqz $a0, equal_0
    div $a1, $a0
    # L1:
    move $a1, $a0
    mfhi $a0
    jal def_GCD

equal_0:
    lw $ra, 0($sp)
    addi $sp, $sp,4 
    add $a0, $a1, $zero
    jr $ra

# divi:   
#     div $a1, $a0
#     move $a1, $a0
#     mfhi $a0
#     j L1

exit:
    li $v0,10
    syscall