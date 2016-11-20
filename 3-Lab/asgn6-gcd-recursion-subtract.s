#   
#           "GCD Recusive"
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
    li $v0,4
    la $a0,str_prompt

    li $v0,4
    la $a0,str_a
    syscall
    li $v0,5
    syscall
    move $s0, $v0        # input a

    li $v0, 4
    la $a0, str_b
    syscall
    li $v0, 5
    syscall
    move $a1, $v0        # input b

    li $v0, 4
    la $a0, str_ans
    syscall
    move $a0, $s0
    jal def_GCD

    li $v0,1
    syscall

    j exit

def_GCD:	
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    beq $a0, $a1, rec_back

    bgt $a0, $a1, sub_a0
    sub $a1, $a1, $a0
    L1:	
    jal def_GCD

rec_back:
    lw $ra, 0($sp)
    addi $sp, $sp,4	
    jr $ra

sub_a0:	
    sub $a0, $a0, $a1
    j L1

exit:
    li $v0,10
    syscall