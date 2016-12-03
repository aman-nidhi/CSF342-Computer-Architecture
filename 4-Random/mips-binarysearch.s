#   
#           "Binary Search in MIPS assembly"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    array:      .word 0, 1, 2, 3, 4, 5, 6

.text
.globl main
main:
                        # load the args for function call
    la $a0, array       # array
    li $a1, 4           # val we are looking for
    li $a2, 0           # lo
    li $a3, 6           # hi
    jal binarySearch    # call the binary Search

    move $a0, $v0       # print out res
    li $v0, 1
    syscall

    li $v0, 10          # end program
    syscall


binarySearch:
                        # recursive alg to find element in an array
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)      # probs don't need this
    sw $a1, 8($sp)      # probs don't need this
    sw $a2, 12($sp)
    sw $a3, 16($sp)

    
    slt $t0, $a3, $a2   # if hi < low, stop recursing
    li $t1, 1
    beq $t0, $t1, valueNotFound

                        # Calculate middle index (n = $t0)
    sub $t0, $a3, $a2   # $t0 = hi - lo
    li $t1, 2
    div $t0, $t1
    mflo $t0
    add $t0, $t0, $a2   # lo + diff(lo, hi) = avg w/out overflow concerns
    add $t3, $t0, $t0   # doubling
    add $t3, $t3, $t3   # doubling again (remember, 4 bytes per word)

                        # Get array[n] = $t2
    add $t2, $t0, $a0   # $t2 = address of array[n]
    lw $t2, 0($t2)      # $t2 = array[n]

    blt $a1, $t2, recurseToLeft
    bgt $a1, $t2, recurseToRight
    move $v0, $t0       # return n, the index if val = array[n]
    j end

    recurseToLeft:
                        # array, val, lo = same, hi = n-1
        addi $t0, $t0, -1
        move $a3, $t0
        jal binarySearch
        j end

    recurseToRight:
                        # array, val, hi = same, lo = n + 1
        addi $t0, $t0, 1
        move $a2, $t0
        jal binarySearch
        j end

    valueNotFound:
        li $v0, -1      # if value is not found return -1

    end:
        lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $a2, 12($sp)
        lw $a3, 16($sp)
        addi $sp, $sp, 20
        jr $ra
