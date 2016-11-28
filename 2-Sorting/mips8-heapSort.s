# 
# 
#       "Heap Sort in MIPS"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
    space:          .asciiz " "         # a space string.
    line:           .asciiz "\n"        # a newline string.
    colonsp:        .asciiz ": "        # a colon string with space.
    comb_gap:       .double 1.3
    array:          .word   0 : 1000    # an array of word, for storing values.
    # array:          .word 34 5 88 4 56 98 7  70 23 63 44 87   # sample array
    size:           .word   12          # actual count of the elements in the array. initialise to sample array length
    params_info_str:                    .asciiz "Input number of values to be sorted (0 < N < 1000): \n"
    instruct:                           .asciiz "Input each value: \n"
    input_values_loop_iter_string:      .asciiz "Your Input value # "
    sorted_array_string:                .asciiz "Sorted:\n"


.text
.globl  main
main:
    params_info:
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

    la $a0, array
    lw $a1, size
    li $a3, 0
    jal Heap_sort
    jal print
    j exit

###      Heap Sort
Heap_sort:




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
        