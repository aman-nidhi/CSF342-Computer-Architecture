#   
#           "Reverse a String"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    msg:            .ascii  "\nReversing a String\n"
    str_prompt:     .asciiz "Please enter a string: "
    orig_str:       .asciiz "\nOriginal: "
    rev_str:        .asciiz "\nReversed: "
    newline:        .asciiz "\n"
    str:            .space  1024 # reserved 1024 bytes for the string
    io_error:       .ascii  "No input given.. error "

.text
.globl  main
main:
    la $a0, message             # print( about this program )
    jal def_print_string

    la $a0, str_prompt          # print( ask input )
    jal def_print_string

    la $a0, str                 # scanf( get input in str )
    la $a1, 1024
    jal def_read_string

    la $a0, str                 # Get the length of the string...
    jal def_strlen
    
    addi $v0, $v0, -1           # strlen - 1
    sb $zero, str($v0)          # Replace newline with a NULL
    
    beqz $v0, str_io_error      # If no input was given, goto no_input

    la $a0, orig_str            # print("Original" )
    jal def_print_string    

    la $a0, str                 # print( "string" )
    jal def_print_string

    la $a0, rev_str             # print( "reverse" )
    jal def_print_string



    la $a0, str                 # Get the length of the string...
    jal def_strlen
    
    move $a1, $v0               # Move string length to $a1

    la $a0, str                 # reverse( instr )
    jal def_rev_string

    la $a0, str
    jal def_print_string        # print( instr )


    j exit                      # exit()

#   Inputs:
#   $a0: the string, 
#   $a1: the string length 
# 
def_rev_string:
    addi $a1, $a1, -1           # string length - 1 (null terminator)
    blt $a1, 1, rev_return      # If the string has size 1 or less, return
    add $a1, $a0, $a1           # $a0 = addr of start, $a1 = $a0 + strlen
    rev_while:
        lb $t2, 0($a0)          # Swap the bytes
        lb $t3, 0($a1)          # string[start] = string[end]
        sb $t2, 0($a1)          # string[end] = string[start]
        sb $t3, 0($a0)

        addi $a0, $a0, 1        # start++, end--
        addi $a1, $a1, -1
        blt $a0, $a1, rev_while # if start < end, goto while loop again

    rev_return:
        jr $ra

# Inputs:
#   $a0: the string
#
# Returns:
#   $v0: the string's length including the new line 
#
def_strlen:
    move $v0, $zero                 # Begins at zero length
    strlen_while:                   # While we're not at the end..
        lb $t0, ($a0)               # Get the current character
        beqz $t0, strlen_return     # If we're at the end, goto return
        addi $v0, $v0, 1            # Else, increment strlen and
        addi $a0, $a0, 1            # the current index.. 
        j strlen_while

    strlen_return:
        jr $ra

# Inputs:
#   $a0: the string you want to print
#
def_print_string:
    li $v0, 4                   # print( $a0 ) -> Prints a string to stdout
    syscall                     # expects $a0 to be the string address

    la $a0, newline               # print a new line
    li $v0, 4
    syscall
    jr $ra                      # return

# Inputs:
#   $a0: the string buffer
#   $a1: the string size
#
def_read_string:
    li $v0, 8                   # Read a string from the user
    syscall                     # Expects buffer to be in $a0, size in $a1
    jr $ra               


# error message and then jumps to exit()
#
str_io_error:
    la $a0, io_error
    jal def_print_string
    j exit

# exit program
# 
exit:
    li $v0, 10   
    syscall
