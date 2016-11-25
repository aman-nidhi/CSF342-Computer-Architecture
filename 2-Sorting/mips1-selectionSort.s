# 
# 
#       "Selection Sort in MIPS"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
    space:          .asciiz " "         # a space string.
    line:           .asciiz "\n"        # a newline string.
    colonsp:        .asciiz ": "        # a colon string with space.
    .align 2
    array:          .word   0 : 1000    # an array of word, for storing values.
    # array:  	   .word 45 44 43 
    size:           .word   3           # actual count of the elements in the array.
                    
    question:       .asciiz "Input number of values to be sorted (0 < N < 1000): "
    instruct:       .asciiz "Input each value: "
    receive_values_loop_iter_string:    .asciiz "Input value#"
    sorted_array_string:                .asciiz "Sorted:\n"
    unsorted_array_string:              .asciiz "Unsorted:\n"


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
                                #             
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
        la $a0, unsorted_array_string
        li $v0, 4
        syscall
        jal print               # printing user input values

        jal def_Selection_Sort
        jal print
        j exit


###  Selection sort
def_Selection_Sort:
sort_prep:
    la  $t0, array              # address of the array
    lw  $t1, size               # load array size to $t1.
    addi $t7, $t1, -1           # t7 = size -1 
    li  $t2, 0                  # outer loop iter 
    li  $t3, 1                  # inner loop iter starts at one place after the outer loop 

outer_loop:
    la  $t0, array              # address of array
    bge $t2, $t7, outer_loop_end        # t2 outer loop iter 

    inner_loop:
        bge $t3, $t1, inner_loop_end    # inner loop iter
                                #         
        mul $t4, $t2, 4         # index i: outer iter
        add $t4, $t4, $t0       # index address of ith element
        add $a0, $zero, $t4
        lw $t4, ($t4)           # last in the stack

        mul $t5, $t3, 4
        add $t5, $t5, $t0       # index j
        add $a1, $zero, $t5
        lw $t5, ($t5)           #
        
        bgt $t4, $t5, swap

    swap_return:
        addi $t3, $t3, 1
        j inner_loop
                                #    
    inner_loop_end:          
        addi $t2, $t2, 1        # inc outer iter t2
        addi $t3, $t2, 1
        j outer_loop
                                
    swap:
        lw  $s0, 0($a0)         # swaping the values
        lw  $s1, 0($a1)
        sw  $s0, 0($a1)
        sw  $s1, 0($a0)
        j swap_return

outer_loop_end:
    li $v0, 4
    la $a0, line
    syscall
    la $a0, sorted_array_string
    syscall
    jr $ra
  

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
        
