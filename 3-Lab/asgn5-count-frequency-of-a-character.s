#   
#           "Count Freq"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    msg:            .ascii  "\nCount Freq\n"
    newline:        .asciiz "\n"
    str:            .asciiz "this is comp arch course"
    key:            .byte   'a'
    io_error:       .ascii  "No input given.. error "

.text
.globl  main
main:
    la $a0, msg             # print( about this program )
    jal def_print_string

    # la $a0,key
    # li $a1,1
    # jal def_read_string
    
    la $a0, str
    jal def_strlen
    add $t1, $v0, $zero     # length of the string in t1

    jal def_countFreq

    j exit

def_countFreq:
    loop_prep:
        li $t2, 0           # counter of freq
        lb $t3, key
        addi $t1, $t1, -1
        li $t0, 0
    loop:
        bge $t0, $t1, loop_end
        lb $t4, str($t0)
        beq $t4, $t3, inc_count
        inc_count_return:
        addi $t0, $t0, 1
        j loop
    loop_end:
        li $v0, 1
        addi $a0, $t2, 0
        syscall
        jr $ra

inc_count:
    addi $t2, $t2, 1
    j inc_count_return

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
