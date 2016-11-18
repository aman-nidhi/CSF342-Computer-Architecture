# 
#
#		"Remove Vovels from String"
#		Author: Aman Nidhi
#		Year  : 2016
# 
# 
.data
    theStr:     .space  100
    prompt:     .asciiz "Input a string: "
    output:     .asciiz "output string: "
    newline:    .asciiz "\n"

.text
    .globl  main
    main:
        li $v0, 4           # display prompt
        la $a0, prompt
        syscall
        
        li $v0, 8           # get string
        la $a0, theStr
        li $a1, 100
        syscall

        jal def_remVowel

        j exit

def_remVowel:
    prep:
        li $t1, 0           # initiate index
        li $t3, 0           # vowel counter
    poploop:
        lb $t0 theStr($t1)
                            # check if vowel
        li $t2, 'a'     
        beq $t0, $t2, isVowel
        li $t2, 'e' 
        beq $t0, $t2, isVowel
        li $t2, 'i'
        beq $t0, $t2, isVowel
        li $t2, 'o' 
        beq $t0, $t2, isVowel
        li $t2, 'u' 
        beq $t0, $t2, isVowel

        sub $t2, $t1, $t3   # if not a vowel
        sb $t0, theStr($t2)    # store at $t2
        j next
    isVowel:                # if vowel, inc count
        addi $t3, $t3, 1

    next:
        addi $t1, $t1, 1
        beqz $t0, done      # once we reach null char, finish
        j poploop

    done:  
        li $v0, 4
        la $a0, output
        syscall 
        li $v0, 4
        la $a0, theStr
        syscall
        jr $ra

exit:
    li $v0, 10          # exit program
    syscall

