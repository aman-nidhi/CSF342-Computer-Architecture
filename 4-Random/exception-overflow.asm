
.data
    X:      .word       7

.text
.globl main
    main:	
        li $t0, 2147483647	# Put MAXINT into $t0
        li $t1, 5000
        add $a0, $t0, $t1	# Try to add MAXINT + 5000, should fail	

        li $v0, 10		    # Exit
        syscall

