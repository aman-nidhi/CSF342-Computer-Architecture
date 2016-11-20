# 
# 
#           "Calculate String Length using recursion"
#           Author: Aman Nidhi
#           Year  : 2016
# 
# 
.data
   .align 2
    theStr:   .asciiz "Aman-Nidhi"

.text
    .globl main
    main:
        la $a0, theStr
        jal str_len         # funtion call		

        move $a0, $v0       # move the length of the string into the arguement for the syscall
        li $v0, 1           # indicates that we are printing out an integer
        syscall             # print out the length of the string

        j exit

    str_len:
        addi $sp, $sp, -8
        sw $ra, 0($sp)
        sw $s0, 4($sp)

        lbu $s0, 0($a0)
        bnez $s0, recurse
        li $v0, 1
        j end

    recurse:
        addi $a0, $a0, 1
        jal str_len
        add $v0, $v0, 1

    end:
        addi $sp, $sp, 8
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        jr $ra

exit:
    li $v0, 10
    syscall
