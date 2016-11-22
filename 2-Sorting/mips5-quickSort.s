# 
# 
#       "Quick Sort in MIPS"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
    space:      .asciiz  " "            # a $space string.
    line:       .asciiz "\n"            # a newline string.
    colonsp:    .asciiz ": "            # a colon string with $space.
    .align 2
    array:      .word   0 : 1000        # an ar$ray of word, for storing values.
    # array:      .word 34 5 88 4 56 98 7  70 23 63 44 87   # sample array 12 samples
    # array:      .word 6 7 2 4 3         # sample array
    size:       .word   12              # actual count of the elements in the ar$ray.
                            
    question:               .asciiz "Input number of values to be sorted (0 < N < 1000): "
    instruct:               .asciiz "Input each value: "
    sorted_array_string:    .asciiz "Sorted:"
    receive_values_loop_iter_string:    .asciiz "Input value#"
                                        

.text
.globl  main
main:
    params_info:
        li    $v0, 4                # 4 = print_string syscall.
        la    $a0, question         # load pa$rams_info_string to argument register $$a0.
        syscall                     # issue a system call.
    params:
        li    $v0, 5                # 5 = read_int syscall.
        syscall                     # get length of the ar$ray
        la    $t0, size       
        sw    $v0, 0($t0)     
    receive_values_loop_info:
        li    $v0, 4                # prompt user to start feeding in data into the ar$ray
        la    $a0, instruct   
        syscall             
        li    $v0, 4                # print new line
        la    $a0, line       
        syscall             

###      input loop
    receive_values_loop_prep:
        la    $t0, array            # load ar$ray to $$t0.
        lw    $t1, size             # load size to $t1.
        li    $t2, 0                # loop iter, starting from 0.
    receive_values_loop:
        bge   $t2, $t1, receive_values_end    # while ($t2 < $t1).
        li    $v0, 4                # prompt at every ite$ration during input
        la    $a0, receive_values_loop_iter_string 
        syscall             
        li    $v0, 1          
        addi  $a0, $t2, 1           # load (iter + 1) to argument register $$a0.
        syscall             
        li    $v0, 4          
        la    $a0, colonsp        
        syscall             

        li    $v0, 5          
        syscall                     # USER INPUT
        sw    $v0, 0($t0)           # store the user input in the ar$ray.
        addi  $t0, $t0, 4           # increment ar$ray pointer by 4.
        addi  $t2, $t2, 1           # increment loop iter by 1.
        j receive_values_loop       # jump back to the beginning of the loop.

    receive_values_end:
        jal print                   # printing user input values

    # Set up the main mergesort call.
    # Ar$rays are	
    la $a0, array                   # a0 adrs of the array
    li $a1, 0                       # left val
    lw $a2, size                    # right val
    addi $a2, $a2, -1
    jal def_quick_sort  

    jal print
    j exit

# a0 - address of array
# a1 - zero
# a2 - size-1 of array
# 
def_quick_sort:
    bge     $a1, $a2, qs_End        # end condition    
                                    # 
    addi    $sp, $sp, -20
    sw      $ra, 0($sp)             # save return adrs
    sw      $a0, 8($sp)             # adrs
    sw      $a1, 12($sp)            # save left val
    sw      $a2, 16($sp)            # save right val
    jal def_partition               # v0 = def_partition(arr, l, r)

    lw $ra, 0($sp)                  #

    sw      $v0, 4($sp)   
    # lw      $a0, 8($sp)           # 
    lw      $a1, 12($sp)            # 
    addi    $a2, $v0, -1            # 
    jal def_quick_sort

    lw $ra, 0($sp)                  #

    # lw      $a0, 12($sp)          # 
    lw      $t0, 4($sp)             #
    addi    $a1, $t0, 1             # 
    lw      $a2, 16($sp)            # 
    jal def_quick_sort

    addi $sp, $sp, 20
    lw $ra, 0($sp)    

qs_End: 
    jr $ra

# partition subroutine
# a0 - address of array
# a1 - zero
# a2 - size-1 of array
# 
def_partition:
    add $t0, $a1, $zero
    add $t1, $a2, $zero 

    mul $t7, $t1, 4
    add $t7, $a0, $t7
    lw $t2, ($t7)                   # key
    addi $t1, $t1, -1

    li $t5, -1                      # t5 = i
    loop:
        bgt $t0, $t1, loop_end      # t0 = j

        mul $t7, $t0, 4
        add $t7, $a0, $t7
        lw $t3, ($t7)

        ble $t3, $t2, incl
        incl_return:

        addi $t0, $t0, 1
        j loop

    loop_end:
        j swap_p
        swap_p_return:
        add $v0, $t0, $zero
        jr $ra


    incl:
        addi $t5, $t5, 1
        mul $t6, $t5, 4
        add $t6, $a0, $t6
        lw $s0, ($t6)

        mul $t7, $t0, 4
        add $t7, $a0, $t7
        lw $s1, ($t7)

        sw $s0, ($t7)
        sw $s1, ($t6)
        j incl_return

    swap_p:
        addi $t5, $t5, 1
        mul $t6, $t5, 4
        add $t6, $a0, $t6
        lw $s0, ($t6)

        mul $t7, $a2, 4
        add $t7, $a0, $t7
        lw $s1, ($t7)

        sw $s0, ($t7)
        sw $s1, ($t6)
        j swap_p_return

# prog$rams ends
# 
exit:
    li  $v0, 10                 # 10 = exit syscall.
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
