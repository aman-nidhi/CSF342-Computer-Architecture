# 
# 
#       "Comb Sort in MIPS"
#       Author: Aman Nidhi
#       Year  : 2016
# 
# 
.data
    space:          .asciiz " "         # a space string.
    newline:        .asciiz "\n"        # a newline string.
    colonsp:        .asciiz ": "        # a colon string with space.
    comb_gap:       .double 1.3
    # array:          .word   0 : 1000    # an array of word, for storing values.
    array:          .word 34 5 88 4 56 98 7  70 23 63 44 87   # sample array
    size:           .word   12          # actual count of the elements in the array. initialise to sample array length
    params_info_str:                    .asciiz "Input number of values to be sorted (0 < N < 1000): \n"
    instruct:                           .asciiz "Input each value: \n"
    input_values_loop_iter_string:      .asciiz "Your Input value # "
    sorted_array_string:                .asciiz "Sorted:\n"


.text
.globl  main
main:
    # params_info:
    #     li  $v0, 4              # 4 = print_string syscall.
    #     la  $a0, params_info_str   # load params_info_str to argument register $a0.
    #     syscall                 # issue a system call.
    # params:
    #     li  $v0, 5              # 5 = read_int syscall.
    #     syscall                 # issue a system call.
    #     la  $t0, size           # load address of size to $t0.
    #     sw  $v0, 0($t0)         # store returned value in $v0 to size.
    # receive_values_loop_info:
    #     li  $v0, 4              # 4 = print_string syscall.
    #     la  $a0, instruct       # load Instruction to argument register $a0.
    #     syscall                 # issue a system call.
    
    # ###     input Loop
    # receive_values_loop_prep:
    #     la  $t0, array          # load array to $t0.
    #     lw  $t1, size           # load size to $t1.
    #     li  $t2, 0              # loop runner, starting from 0.
    # input_values_loop:
    #     bge $t2, $t1, input_values_end    # while ($t2 < $t1).
    #     li  $v0, 4
    #     la  $a0, input_values_loop_iter_string
    #     syscall
    #     li  $v0, 1          
    #     addi $a0, $t2, 1        # counter 
    #     syscall             
    #     li  $v0, 4          
    #     la  $a0, colonsp        # load colonsp to argument register $a0.
    #     syscall             

    #     li  $v0, 5          
    #     syscall             
    #     sw  $v0, 0($t0)         # store returned value from syscall in the array.
    #     addi    $t0, $t0, 4     # increment array pointer by 4.
    #     addi    $t2, $t2, 1     # increment loop runner by 1.
    #     j   input_values_loop   # jump back to the beginning of the loop.

    # input_values_end:
    #     jal print               # call print routine.

    la $a0, array
    lw $a1, size
    li $a3, 0

    jal Comb_Sort
    jal print
    j exit

###      Comb Sort
Comb_Sort:
    add $s2, $a1, $zero #   gap = size
    li $s3, 0       #   swapped = false
    
    j comb_while_bottom

    comb_while_top:
        
        ble $s2, 1, if_continue # if gap > 1 do following, else continue
        mtc1 $s2, $f1       #   convert (int)gap to single prec. floating point
        cvt.s.w $f1, $f1    #   convert (int)gap to single prec. floating point now $f1 = (double)gap

        l.s $f2, comb_gap   #   loads gap ( = 1.3 ) on to $f2
        
        div.s $f3, $f1, $f2 #   $f3 = (double)(gap / 1.3)
        
        cvt.w.s $f3, $f3    #   
        mfc1 $s2, $f3       #   gap = (int)((double)gap/ 1.3)
        
    
    if_continue:            # not if, continues
        li $s3, 0       #   swapped = false
        
        #   starting of for loop
        add $s1, $zero, $zero   #   i = 0
        j comb_for_bottom

    comb_for_top:
    ########## if else part (inside of the for loop)
        bne $a3, 1, comb_for_not_asc    # branch if not ascending ( != 1 )
        #ascending part
        #   if (input[i] - input[i + gap] > 0)
        sll $t2, $s1, 2     #   $t2 = i*4
        add $t2, $a0, $t2   #   $t2 = input[i]'s address
        
        add $t3, $s1, $s2   #   $t3 = i + gap
        sll $t3, $t3, 2     #   $t3 = (i+gap) * 4
        add $t3, $a0, $t3   #   $t3 = input[i+gap]'s address
        
        lw $t5, 0($t2)      #   get the value of input[i]
        lw $t6, 0($t3)      #   get the value of input[i + gap]
        sub $t4, $t5, $t6   #   $t4 = input[i] - input[i + gap]
        ble $t4, 0, comb_for_update #   if $t4 is NOT >0 then go to increment
        
            add $s0, $t5, $zero #   temp = input[i]
            sw $t3, 0($t2)      #   input[i] = input[i + gap];
            sw $s0, 0($t3)      #   input[i + gap] = temp;
            li $s3, 1       #   swapped = true;
            
    comb_for_not_asc:
        #   if (input[i] - input[i + gap] < 0)
        sll $t2, $s1, 2     #   $t2 = i*4
        add $t2, $a0, $t2   #   $t2 = input[i]'s address
        
        add $t3, $s1, $s2   #   $t3 = i + gap
        sll $t3, $t3, 2     #   $t3 = (i+gap) * 4
        add $t3, $a0, $t3   #   $t3 = input[i+gap]'s address
        
        lw $t5, 0($t2)      #   get the value of input[i]
        lw $t6, 0($t3)      #   get the value of input[i + gap]
        sub $t4, $t5, $t6   #   $t4 = input[i] - input[i + gap]
        bge $t4, 0, comb_for_update #   if $t4 is NOT <0 then go to increment
        
            add $s0, $t6, $zero #   temp = input[i + gap];
            sw $t2, 0($t3)      #   input[i + gap] = input[i];
            sw $s0, 0($t2)      #   input[i] = temp;
            li $s3, 1       #   swapped = true;
            
    comb_for_update:
        addi $s1, $s1, 1    #   i++
    ##########
    comb_for_bottom:        #   for loop testing
        add $t0, $s2, $s1   #   $t0 = gap + i
        blt $t0, $a1, comb_for_top  # gap + i < size
            
        
    comb_while_bottom:      #   while loop testing
        sgt $t1, $s2, 1     #   gap > 1 => $t1=1
        or $t1, $t1, $s3    #   $t1=1 if (gap>1 || swapped)
        beq $t1, 1, comb_while_top
        
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
        la  $a0, newline
        syscall
        jr  $ra
        
