#   
#           "is Number palindrome, checking if a number is palindrome or not"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    prompt:     .asciiz     "Enter value on n: "
    true:       .asciiz     "the number is palindrome"
    false:      .asciiz     "the number is not palindrome"

.text
main:
    la $a0, prompt
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $a1, $v0				#$t0 = n

    add $a0, $a1, $zero
    jal Reverse
    jal isPalindrome

    j exit

Reverse:
    li $s0, 0       # sum for the reverse 
    li $t0, 10      # 10 constant
    li $t2, 0
    loop:
        ble $a0, $t2, loop_end
        div $a0, $t0
        mfhi $t1    # remainder
        mul $s0, $s0, $t0
        add $s0, $s0, $t1
        div $a0, $a0, $t0
        j loop

    loop_end:
        addi $a0, $s0, 0
        jr $ra

isPalindrome:
    beq $a0, $a1, lab_true
    beq $a0, $a1, lab_flase  

    lab_flase:
        la $a0, false
        li $v0, 4
        syscall
        jr $ra 

    lab_true:
        la $a0, true
        li $v0, 4
        syscall
        jr $ra      

exit:
    li $v0, 10
    syscall