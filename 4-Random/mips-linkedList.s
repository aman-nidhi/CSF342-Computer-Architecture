#   
#           "Linked List in MIPS Assembly"
#           Author: Aman Nidhi
#           Year  : 2016
#           
# 
.data
    head:       .word   0
    newline:    .asciiz "\n"

.text
.globl main
main:
    li $a0, 4
    jal def_create_node     # Create node 
    move $a0, $v0
    jal def_insertNode      # Insert node into linked list

    li $a0, 3
    jal def_create_node
    move $a0, $v0
    jal insertNode

    li $a0, 5
    jal def_create_node
    move $a0, $v0
    jal def_insertNode

    jal def_printList

    li $v0, 10              # Exit the program
    syscall

def_create_node:            # Create Node Function
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    move $t0, $a0

    li $v0, 9
    li $a0, 8
    syscall

    sw $t0, 0($v0)          # set node value
    sw $zero, 4($v0)        # node->next = NULL

    lw $s0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

    
def_insertNode:             # Insert node into the linked list
    addi $sp, $sp, -8
    sw  $ra, 0($sp)
    sw $s0, 4($sp)
    move $s0, $a0           # $a0 stores address of the node
    
    lw $t0, head            # temp reference to head

    bnez $t0, insert_while
    
    sw $s0, head            # if head not defined
    j insertNode_end

    insert_while:
        lw $t1, 4($t0)
        beqz $t1, insert_while_end
        move $t0, $t1
        j insert_while

    insert_while_end:
        sw $s0, 4($t0)

    insertNode_end:         # return from Inser Node in Linked List
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addi $sp, $sp, 8
        jr $ra


def_printList:              # Print the linked list
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    lw $s0, head            # Get ref to head
    print_loop:
        beqz $s0, printloop_end

        li $v0, 1           # print integer
        lw $a0, 0($s0)
        syscall             

        li $v0, 4           # print string
        la $a0, newline
        syscall             

        lw $s0, 4($s0)      # update node, node = node -> next
        j print_loop

    printloop_end:          # return from print
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addi $sp, $sp, 8
        jr $ra

