# 
# 
#       "Insertion Sort"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
                                    #
    space:      .asciiz  " "        # a space string.
    line:       .asciiz "\n"        # a newline string.
    colonsp:    .asciiz ": "        # a colon string with space.
    array:      .word   0 : 1000    # an array of word, for storing values.
    # array:  	.word 34 5 88 4 56 98 7
    size:       .word   7           # actual count of the elements in the array.

    question:  		.asciiz "Input number of values to be sorted (0 < N < 1000): "
    instruct:    	.asciiz "Input each value: "
    receive_values_loop_iter_string:    .asciiz "Input value#"
    sorted_array_string:                .asciiz "Sorted:"

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


###       Insertion SORT
sort_prep:
    la  $t0, array          # load array to $t0.
    lw  $t1, size           # load array size to $t1.
    li  $t2, 1              # loop xloop iter(t2), starting from 1.
sort_xloop:
    la  $t0, array          # load array to $t0.
    bge $t2, $t1, sort_xloop_end    # while (t2 < $t1).
    move    $t3, $t2        # copy $t2 to $t3.
    sort_iloop:
        ble $t3, $zero, sort_iloop_end  # while (t3 > 0).
        la  $t0, array      # load array to $t0.
        mul $t5, $t3, 4     
        add $t0, $t0, $t5   # calculate the array index, $t0 is calc from $t3

        lw  $t7, 0($t0)     # load array[$t3] to $t7.
        lw  $t6, -4($t0)    # load array[$t3 - 1] to $t6.
        bge $t7, $t6, sort_iloop_end   # if(array[$t3] > array[$t3 - 1]) then iter the iloop.
        
        lw  $t4, 0($t0)     # swaping the values
        sw  $t6, 0($t0)
        sw  $t4, -4($t0)

        addi $t3, $t3, -1   # decrement innerloop iter($t3) 
        j   sort_iloop      # jump back to the beginning of the sort_iloop.

    sort_iloop_end:
        addi $t2, $t2, 1    # increment loop runner by 1.
        j   sort_xloop      # jump back to the beginning of the sort_xloop.

sort_xloop_end:
    li  $v0, 4              # 4 = print_string syscall.
    la  $a0, sorted_array_string    # load sorted_array_string to argument register $a0.
    syscall                 # issue a system call.
    li  $v0, 4              # 4 = print_string syscall.
    la  $a0, line           # load line to argument register $a0.
    syscall                 # issue a system call.
    jal print               # call print routine.

exit:
    li  $v0, 10             # 10 = exit syscall.
    syscall                 # issue a system call.


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