#   
#           "String Compare"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    str_input_prompt1:      .asciiz   "input first string# \n"    
    str_input_prompt2:      .asciiz   "input second string# \n"
    eq:         .asciiz     "strings are equal \n"
    lss:        .asciiz     "First string is less than second string \n"
    grt:        .asciiz     "First string is greater than second string \n"
    str1:       .space      30   
    str2:       .space      30

.text
main:
    li $v0, 4
    la $a0, str_input_prompt1
    syscall                 
    li $v0, 8
    la $a0, str1      
    li $a1, 25
    syscall                     # got 1st string

    li $v0, 4
    la $a0, str_input_prompt2
    syscall
    li $v0, 8
    la $a0, str2
    li $a1, 25
    syscall                     # got 2nd string

    la $a0, str1                # load adrs of 1st string
    la $a1, str2                # load adrs of 2nd string
    jal strcmp                  # compare method call

    move $a0, $v0               # load result of compare into a0
    beq $a0, 1, greater         # 1st string "larger"
    beq $a0, -1, less           # 2nd string "larger"

    li $v0, 4
    la $a0, eq
    syscall
    j exit

# function to compare string iteratively 
# string1 > string2 if at any point ASCII of char-string1 is greater than ASCII of char-string2
strcmp: 
    add $t0, $zero, $zero       # set t0 to zero
    add $t1, $zero, $a0         # t1 = a0
    add $t2, $zero, $a1         # t2 = a1
    loop:
        lb $t3, 0($t1)          # loab byte from first string
        lb $t4, 0($t2)          # load byte form second string
        beqz $t3, str1_end      # string1 ends before string2
        beqz $t4, str_greater   # at null char in string 2
        blt $t3, $t4, str_less
        bgt $t3, $t4, str_greater 
        addi $t1, $t1, 1        # look at next byte
        addi $t2, $t2, 1        # look at next byte
        j loop

        str1_end:     
            bne $t4, 0, str_less # if t4 and t3 are both zero then equal
            li $v0, 0           # both strings ended. return equal
            jr $ra
        str_greater:  
            li $v0, 1           # string1 is larger
            jr $ra
        str_less:     
            li $v0, -1          # string2 is smaller
            jr $ra

greater:
    li $v0, 4
    la $a0, grt
    syscall
    j exit                      # end first string greater
less:
    li $v0, 4
    la $a0, lss
    syscall
    j exit                      # end second string greater

exit:
    li $v0, 10
    syscall
