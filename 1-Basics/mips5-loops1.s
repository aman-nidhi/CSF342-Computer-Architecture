#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
    msg:            .asciiz "whileLoop\n"       
    askub:          .asciiz "Please enter an upperbound for the loop: "     
    asks:           .asciiz "Please enter the step value: "       
    zeroF:          .float  0.0
    newline:        .asciiz "\n"
.text
.globl main
main:
    program_info: 
        la $a0, msg 
        li $v0, 4                          
        syscall                                      
    lwc1 $f5, zeroF                         # general zero
    get_upper_bound:
        la $a0, askub       
        li $v0, 4 
        syscall  

        li $v0, 6                           
        syscall                             # read upperbound
        add.s $f3, $f0, $f5                 # Move to f3

    get_step_value:
        la $a0, asks                        # 
        li $v0, 4                           # 
        syscall                             # 

        li $v0, 6                           # 
        syscall                             # get the step value 
        add.s $f2, $f0, $f5                 # move to f2

    lwc1 $f4, zeroF                         # f4 iter init to 0.0

    while_loop:
        c.lt.s $f4, $f3                     # while condition , flag=true when f4>f3
        bc1f loop_exit                      # checking with the flag and branching 
        jal print_val                       # print val
        add.s $f4, $f4, $f2                 # increment 
        j while_loop 

    loop_exit:
        j exit

    print_val:                              
        add.s $f12, $f4, $f5                            
        li $v0, 2
        syscall                             # Print value 
        li $v0, 4
        la $a0, newline                      
        syscall                             # newline
        jr $ra        

# Exit cleanly from the program
#
exit:
    li $v0, 10                               # Load the exit function
    syscall                                  # Exit gracefully 
