#   
#           "Replace Character in String in MIPS assembly"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    str:        .space      1024
    char:       .space      2
    char1:      .space      2
    char2:      .space      2
    option:      .word       0, 0, 0, 0
    len:        .asciiz     "Length of the string: "
    pr1:        .asciiz     "Enter a character: "
    pr2:        .asciiz     "Enter a character you want to replace: "
    pr3:        .asciiz     "\nEnter a character you want to replace with: "
    freq:       .asciiz     "\nFrequency of the character: "
    repl:       .asciiz     "\nString after replacing the character: "
    inp1:       .asciiz     "Enter a string: "
    inp2:       .asciiz     "Enter a case: \n0: Find length of string.\n1: Find frequency of a character.\n2: 
                                Replace a character.\n"

.text
main:
    li $v0, 4
    la $a0, inp1
    syscall

    li $v0, 8
    la $a0, str
    li $a1, 1024
    syscall

    li $v0, 4
    la $a0, inp2
    syscall

    li $v0, 5
    syscall
    move $t2, $v0
    mul $t2, $t2, 4

    j switch
    # main ends here                        


    case0:                          # finding the length of the string
        li $t4, -1	
        la $t0, str
        loop1:
            lb $t3, 0($t0)
            beq $t3, $zero, out1
            addi $t4, $t4, 1        # calculate length
            addi $t0, $t0, 1
            j loop1

        out1:
        li $v0, 4
        la $a0, len
        syscall

        li $v0, 1
        move $a0, $t4
        syscall
        j exit	

    case1:                          # finding the frequency of a character
        li $v0, 4
        la $a0, pr1
        syscall

        li $v0, 8
        la $a0, char
        li $a1, 2
        syscall

        li $t4, 0
        la $t0, str
        lb $t7, char
        loop2:
            lb $t3, 0($t0)
            beq $t3, $zero, out2
            bne $t3, $t7, na
            addi $t4, $t4, 1        # counting the freq
            na:
            addi $t0, $t0, 1        # next iter
            j loop2

        out2:
        li $v0, 4
        la $a0, freq
        syscall

        li $v0, 1
        move $a0, $t4
        syscall
        j exit

    case2:                          # replacing the character in the string
        li $v0, 4
        la $a0, pr2
        syscall

        li $v0, 8
        la $a0, char1
        li $a1, 2
        syscall

        li $v0, 4
        la $a0, pr3
        syscall

        li $v0, 8
        la $a0, char2
        li $a1, 2
        syscall

        la $t0, str
        lb $t7, char1
        lb $t8, char2
        loop3:
            lb $t3, 0($t0)
            beq $t3, $zero, out3
            bne $t3, $t7, neq
            sb $t8, 0($t0)
            neq:
            addi $t0, $t0, 1
            j loop3

        out3:
        li $v0, 4
        la $a0, repl
        syscall

        li $v0, 4
        la $a0, str
        syscall		
        j exit

    switch:	
        la $t0, case0
        sw $t0, option

        la $t0, case1
        sw $t0, option+4

        la $t0, case2
        sw $t0, option+8

        la $s0, option
        add $s0, $s0, $t2	
        lw $t3, 0($s0)
        jr $t3

exit:
    li $v0, 10
    syscall			
