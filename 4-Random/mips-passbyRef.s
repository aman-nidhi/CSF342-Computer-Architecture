.data
    .align 2
    x:      .word 9
    y:      .word 4
    STR_NEWLINE:        .asciiz "\n"
    COMMA:              .asciiz ", "

.text
.align 2
.globl main
main:
    la $s0, x               # Load locations in memory of x and y global variables
    la $s1, y

    li $v0, 1               # printing x
    lw $a0, 0($s0)
    syscall

    li $v0, 4               # formatting
    la $a0, COMMA
    syscall

    li $v0, 1               # printing y
    lw $a0, 0($s1)
    syscall

    li $v0, 4               # newline
    la $a0, STR_NEWLINE
    syscall

    move $a0, $s0
    move $a1, $s1
    jal swap                # function call

    li $v0, 1               # printing x
    lw $a0, 0($s0)
    syscall

    li $v0, 4               # formatting
    la $a0, COMMA
    syscall

    li $v0, 1               # printing y
    lw $a0, 0($s1)
    syscall
    
    li $v0, 10              # Exit program exectution
    syscall


swap:
    addi $sp, $sp, -8       # Allocate space in stack to save registers
    sw $s0, 0($sp)
    sw $s1, 4($sp)

                            # do all the manipulation of stack
    lw $s0, 0($a0)          # s0 = *x
    lw $s1, 0($a1)          # s1 = *y

    sw $s0, 0($a1)          # *y = *x
    sw $s1, 0($a0)          # *x = *y

    lw $s0, 0($sp)          # Pop saved variables off the stack
    lw $s1, 4($sp)
    addi $sp, $sp, 8        # restore the stack back to when this function was called
    jr $ra                  # Jump to return address

