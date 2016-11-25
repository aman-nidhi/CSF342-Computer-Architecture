# 
# 
#       "Merge Sort"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
    space:          .asciiz  " "        # a space string.
    line:           .asciiz "\n"        # a newline string.
    colonsp:        .asciiz ": "        # a colon string with space.
    array:          .word   0 : 1000    # an array of word, for storing values.
    # array:          .word 34 5 88 4 56 98 7  70 23 63 44 87   # sample array
    size:           .word   12          # actual count of the elements in the array. initialise to sample array length
                                        # but during the execution, it get updated by the user input
    question:       .asciiz "Input number of values to be sorted (0 < N < 1000): "
    instruct:       .asciiz "Input each value: "
    receive_values_loop_iter_string:    .asciiz "Input value#"
    sorted_array_string:                .asciiz "Sorted:"
    infinity:       .word 0x7FFFFFFF

.text
.globl  main
main:
    params_info:
        li  $v0, 4              # 4 = print_string syscall.
        la  $a0, question       # load params_info_string to argument register $a0.
        syscall                 # issue a system call.
    params:
        li  $v0, 5              # 5 = read_int syscall.
        syscall                 # get length of the array
        la  $t0, size       
        sw  $v0, 0($t0)     
    receive_values_loop_info:
        li  $v0, 4              # prompt user to start feeding in data into the array
        la  $a0, instruct   
        syscall             
        li  $v0, 4              # print new line
        la  $a0, line       
        syscall             

###      input loop
    receive_values_loop_prep:
        la  $t0, array          # load array to $t0.
        lw  $t1, size           # load size to $t1.
        li  $t2, 0              # loop iter, starting from 0.
    receive_values_loop:
        bge $t2, $t1, receive_values_end    # while ($t2 < $t1).
        li  $v0, 4              # prompt at every iteration during input
        la  $a0, receive_values_loop_iter_string 
        syscall             
        li  $v0, 1          
        addi    $a0, $t2, 1     # load (iter + 1) to argument register $a0.
        syscall             
        li  $v0, 4          
        la  $a0, colonsp        
        syscall             

        li  $v0, 5          
        syscall                 # USER INPUT
        sw  $v0, 0($t0)         # store the user input in the array.
        addi    $t0, $t0, 4     # increment array pointer by 4.
        addi    $t2, $t2, 1     # increment loop iter by 1.
        j receive_values_loop   # jump back to the beginning of the loop.

    receive_values_end:
        jal print               # printing user input values

    # Set up the main mergesort call.
    # Arrays are	
    la $a0, array               # $a0 <= &A
    li $a1, 1
    lw $a2, size
    jal mergeSort   

    jal print
    j exit



# Merge Funtion here
# 
# 
merge:
    # $a0 => &A
    # $a1 => p
    # $a2 => q
    # $a3 => r                  #
    addi $sp, $sp, -8
    sw $s0, 0($sp)              # Nothing is actually being stored in these, but it's good practice I guess
    sw $s1, 4($sp)

    sub $t0, $a2, $a1           # $t0 = n1 = q - p + 1
    addi $t0, $t0, 1

    sub $t1, $a3, $a2           # $t1 = n2 = r - q

    addi $t4, $0, 4             # t4 = 4
    addi $t2, $0, 1             # $t2 = i = 1

    # Left array
    store_L:
        add $t5, $a1, $t2       # $t5 = p + i - 1
        addi $t5, $t5, -1

        mul $t5, $t5, $t4       # multiply $t5 by 4 for word offsets
        add $t5, $t5, $a0       # $t5 = &A[p+i-1]
        addi $t5, $t5, -4       # modify for 1-indexing

        lw $t6, 0($t5)
        addi $sp, $sp, -4       # Push A[p+i-1] onto the stack
        sw $t6, 0($sp)

        addi $t2, $t2, 1        # i++
        ble $t2, $t0, store_L   # if i <= n1, loop


    la $t6, infinity            # not part of the loop: add "infinity" as the next stack element
    lw $t6, 0($t6)
    addi $sp, $sp, -4
    sw $t6, 0($sp)

    addi $t2, $0, 1             # $t2 = j = 1

    # right array
    store_R:
        add $t5, $a2, $t2       # $t5 = q + j
        mul $t5, $t5, $t4       # multiply $t5 by 4 for word offsets

        add $t5, $t5, $a0       # $t5 = &A[q + j]
        addi $t5, $t5, -4       # because 1-indexed

        lw $t6, 0($t5)          # $t6 = A[q + j]

        addi $sp, $sp, -4
        sw $t6, 0($sp)

        addi $t2, $t2, 1
        ble $t2, $t1, store_R   # repeat while j <= n2

    la $t6, infinity            # not part of the loop: add "infinity" as the next stack element
    lw $t6, 0($t6)
    addi $sp, $sp, -4
    sw $t6, 0($sp)

    # now, execute the merge
    # merging the left and the right array
    # 
    addi $t2, $0, 1             # $t2 = i = 1
    addi $t3, $0, 1             # $t3 = j = 1
    move $t5, $a1               # $t5 = k = p (for k = p to r)

    # 
    mergeloop:
        add $t6, $t0, $t1       # $t6 = &L = $sp + 4(n1 + n2 + 1)
        addi $t6, $t6, 1        # for the infinities 
        mul $t6, $t6, $t4       # multiply for words
        add $t6, $t6, $sp

        addi $t7, $t1, 0        # $t7 = &R = $sp + 4(n2 + 0)
        mul $t7, $t7, $t4
        add $t7, $t7, $sp

        mul $t8, $t2, $t4       # $t8 = &L[i]
        add $t8, $t8, $t6
        addi $t8, -4            # because i and j start at 1

        mul $t9, $t3, $t4       # $t9 = &R[j]
        addi $t9, -4            # because i and j start at 1
        add $t9, $t9, $t7

        lw $t8, 0($t8)          # reusing registers here: moving contents of stored memory location
        lw $t9, 0($t9)          # into the register itself

        mul $s0, $t5, $t4       # $s0 = &A[k]
        add $s0, $s0, $a0
        addi $s0, $s0, -4       # offset for 1-indexing

        ble $t8, $t9, lessorequal
        bgt $t8, $t9, greaterthan

        lessorequal:
            sw $t8, 0($s0)
            addi $t2, -1 
            b mergeloopend

        greaterthan:
            sw $t9, 0($s0)
            addi $t3, -1
            b mergeloopend

    mergeloopend:
        addi $t5, $t5, 1
        ble $t5, $a3, mergeloop	 # if k <= r, repeat

    # clear the stack and return
    mul $t5, $t0, $t4            # $t5 = 4*n1
    add $sp, $sp, $t5            # pop L from stack
    mul $t5, $t1, $t4            # $t5 = 4*n2
    add $sp, $sp, $t5            # pop R from stack

    addi $sp, $sp, 8             # two infinities

    lw $s0, 0($sp)               # unused but good practice?
    lw $s1, 4($sp)               # unused but good practice?

    addi $sp, $sp, 8             # $s0, $s1
    jr $ra

# MergeSort Funtion
# 
mergeSort:
    # $a0 => &A
    # $a1 => p
    # $a2 => r
    bge $a1, $a2, mergesort_pop_stack
    li $t0, 2
    add $t1, $a1, $a2
    div $t1, $t1, $t0       # $t1 = q = (p+r)/2

    addi $sp, $sp, -16
    sw $a1, 0($sp)          # Store p	
    sw $t1, 4($sp)          # Store q
    sw $a2, 8($sp)          # Store r
    sw $ra, 12($sp)         # Store return address

    move $a2, $t1           # Set up mergesort(A, p, q)
    jal mergeSort           # Mergesort(A, p, q)
    lw $ra, 12($sp)         # Restore the return address pointer

    lw $a1, 4($sp)          # Set up mergesort(A, q+1, r)
    addi $a1, $a1, 1
    lw $a2, 8($sp)
    jal mergeSort           # Mergesort(A, q+1, r)

    lw $ra, 12($sp)         # Restore the return address pointer

    lw $a1, 0($sp)          # Set up merge(A, p, q, r)
    lw $a2, 4($sp)
    lw $a3, 8($sp)
    jal merge               # Merge(A, p, q,r)

    lw $ra, 12($sp)         # Restore the return address pointer
    lw $a1, 0($sp)
    lw $t1, 4($sp)
    lw $a2, 8($sp)

    addi $sp, $sp, 16       # clear stack

mergesort_pop_stack:
    jr $ra


# programs ends
# 
exit:
    li  $v0, 10             # 10 = exit syscall.
    syscall  

###       Printing
print:
    print_loop_prep:
        la  $t0, array
        lw  $t1, size
        li  $t2, 0
    print_loop:
        bge $t2, $t1, print_end
        li  $v0, 1
        lw  $a0, 0($t0)
        syscall
        li  $v0, 4
        la  $a0, space
        syscall
        addi    $t0, $t0, 4
        addi    $t2, $t2, 1
        j   print_loop
    print_end:
        li  $v0, 4
        la  $a0, line
        syscall
        jr  $ra
