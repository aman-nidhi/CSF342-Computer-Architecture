#   
#           "is Prime"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    prompt:     .asciiz "Please enter a number: "
    false:      .asciiz "False\n"
    true:       .asciiz "True\n"

.text
.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
                                    #
    li $v0, 5
    syscall
    move $a0, $v0                   # pass the integer read as an argument into isPrime

    jal isPrime

    bne $v0, $zero, success         # if $v0 == 1, then prime, branch to print success message

    li $v0, 4
    la $a0, false
    syscall

    j exit                          # jump to the end of the program

    success:
    li $v0, 4
    la $a0, true
    syscall

    j exit

# Following MIPS calling conventions, allocate space in stack to store callee saved registers
# that you will use
# 
isPrime:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    li $s0, 2                       # $s0 starts at 2 and goes up to n-1
    isPrimeLoop:

    beq $a0, $s0, prime             # if $s0 = n, end

    div $a0, $s0
    mfhi $t0
    beq $t0, $zero, notPrime

    addi $s0, $s0, 1
    j isPrimeLoop

    prime:
        addi $v0, $zero, 1
        j isPrimeEnd

    notPrime:
        add $v0, $zero, $zero

    isPrimeEnd:
        # Restore the original values of the registers from the stack
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        addi $sp, $sp, 8
        jr $ra

exit:
    li $v0, 10
    syscall