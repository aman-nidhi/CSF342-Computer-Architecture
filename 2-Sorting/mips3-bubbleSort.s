# 
# 
#       "Bubble Sort"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
    space:      .asciiz " "         # a space string.
    line:       .asciiz "\n"        # a newline string.
    colonsp:    .asciiz ": "        # a colon string with space.
    array:      .word   0 : 1000    # an array of word, for storing values.
    size:       .word   5           # actual count of the elements in the array.
    params_info_str:    .asciiz "Input number of values to be sorted (0 < N < 1000): \n"
    instruct:           .asciiz "Input each value: \n"
    input_values_loop_iter_string:      .asciiz "Your Input value # "
    sorted_array_string:                .asciiz "Sorted:\n"


.text
.globl  main
main:
    params_info:
                                #
        li  $v0, 4              # 4 = print_string syscall.
        la  $a0, params_info_str   # load params_info_str to argument register $a0.
        syscall                 # issue a system call.
    params:
        li  $v0, 5              # 5 = read_int syscall.
        syscall                 # issue a system call.
        la  $t0, size           # load address of size to $t0.
        sw  $v0, 0($t0)         # store returned value in $v0 to size.
    receive_values_loop_info:
        li  $v0, 4              # 4 = print_string syscall.
        la  $a0, instruct       # load Instruction to argument register $a0.
        syscall                 # issue a system call.
    
###     input Loop
    receive_values_loop_prep:
        la  $t0, array          # load array to $t0.
        lw  $t1, size           # load size to $t1.
        li  $t2, 0              # loop runner, starting from 0.
    input_values_loop:
        bge $t2, $t1, input_values_end    # while ($t2 < $t1).
        li  $v0, 4
        la  $a0, input_values_loop_iter_string
        syscall
        li  $v0, 1          
        addi $a0, $t2, 1        # counter 
        syscall             
        li  $v0, 4          
        la  $a0, colonsp        # load colonsp to argument register $a0.
        syscall             

        li  $v0, 5          
        syscall             
        sw  $v0, 0($t0)         # store returned value from syscall in the array.
        addi    $t0, $t0, 4     # increment array pointer by 4.
        addi    $t2, $t2, 1     # increment loop runner by 1.
        j   input_values_loop   # jump back to the beginning of the loop.

    input_values_end:
        jal print               # call print routine.



###       Bubble SORTING
sort_prep:
    la  $t0, array              # load array to $t0.                 
    lw $t2, size
    add $t2, $t2, -1            # load array size to $t1.
    li  $t1, 0                  # outer loop iter t1

sort_xloop:                     
    la  $t0, array
    bge $t1,$t2, sort_xloop_end # while (t2 < $t1).

    li $t3, 0                   # inner loop iter t3
    lw $t4, size
    addi $t4, $t4, -1
    sub $t4, $t4, $t1
    
    sort_iloop:                
        bge $t3, $t4, sort_iloop_end

        mul $t5, $t3, 4
        add $t5, $t5, $t0  

        mul $t6, $t3, 4
        add $t6, $t6, $t0
        addi $t6, $t6, 4

        add $a0, $t5, $zero
        add $a1, $t6, $zero
        lw $s2, ($a0)
        lw $s3, ($a1)
        bgt $s2, $s3, swap      # if a[j]>a[j+1] then swap
        L1:
        addi $t3, $t3, 1
        j   sort_iloop          # jump back to the beginning of the sort_iloop.

    sort_iloop_end:
        addi $t1, $t1, 1        # increment loop runner by 1.
        j sort_xloop            # jump back to the beginning of the sort_xloop.

sort_xloop_end:
    li  $v0, 4                      # 4 = print_string syscall.
    la  $a0, sorted_array_string    # load sorted_array_string to argument register $a0.
    syscall             
    li  $v0, 4          
    la  $a0, line               # load line to argument register $a0.
    syscall             
    jal print                   # call print routine.

swap: 
    lw $s0, 0($a0)
    lw $s1, 0($a1)
    # Switching the elements
    sw $s0, 0($a1)
    sw $s1, 0($a0)
    j L1

exit:
    li  $v0, 10                 # 10 = exit syscall.
    syscall                     # issue a system call.


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
        