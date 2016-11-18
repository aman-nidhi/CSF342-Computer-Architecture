#
#       Author: Aman Nidhi
#       Year: 2016
# 
#               
.data
    zeroF:      .float   0.0
    zeroD:      .double  0.0
                
.text
## Coprocessor 1 and The Floating-Point Registers
#
#   Floating point handled by co-processor 1, one of 4 co-processors.
#
#   MIPS floating point registers also called co-processor 1 registers.
#   MIPS floating point instructions called co-processor 1 instructions.
#
#   Registers named f0-f31.
#   Each register is 32 bits.  (For MIPS-32)


## Coprocessor 1 Instructions
#
#   Coprocessor 1 instructions use coprocessor 1 (FP) registers.
#   This includes instructions that do FP arithmetic ..
#   .. and other types of instructions.
#
#   Many coprocessor 1 instructions have "c1" in their names ..
#   .. for example, lwc1.
#
#   Coprocessor 1 *arithmetic* instructions *do not* have c1 in their names ..
#   .. but they include a /completer/ that indicates data type ..
#   .. for example, add.d, where ".d" is the completer.
#
#   Completers:
#
#     ".s"  Single-Precision Floating Point (32 bits)
#     ".d"  Double-Precision Floating Point (64 bits)
#     ".w"  Integer (32 bits)


## Double-Precision Operands
#
#   In MIPS-32 (including MIPS-I) FP registers are 32 bits.
#   Instructions with ".d" operands get each operand from a pair of regs.
#   Register numbers must be even.
#   :Example:
        # add.d $f0, $f2, $f4  # {$f0,$f1} = { $f2, $f3 } + { $f4, $f5 }
        # add.d $f0, $f2, $f5  # ILLEGAL in MIPS 32, because f5 is odd.

## Immediate Operands and Constant Registers
#   MIPS FP instructions do not take immediate values.
        # addi.s $f0, $f1, 2.3   # ILLEGAL, no immediate FP instructions.

#   There is no counterpart of integer register 0 ($0 aka r0 aka $zero).
        # add.s $f0, $f1, $f2    # f0 has the sum,

## Arithmetic Operations
# Add double-precision (64-bit) operands.
		# add.d $f0, $f2, $f4

#
## Load and Store
# Load double (eight bytes into two consecutive registers).
		# ldc1 $f0, 8($t0)
#
## Move Between Register Files (E.g., integer to FP)
		# mtc1   $t0, $f0

## Format Conversion
# Convert from one format to another, e.g., integer to double.
		# cvt.d.w  $f0, $f2

 ## FP Load and Store
    # Load word in to coprocessor 1
    lwc1 $f0, 4($t4)   #  $f0 = Mem[ $t4 + 4 ]
    #
    # Load double in to coprocessor 1
    ldc1 $f0, 0($t4)   #  $f0 = Mem[ $t4 + 0 ];  $f1 = Mem[ $t4 + 4 ]
    #
    # Store word from coprocessor 1.
    swc1 $f0, 4($t4)   #  $f0 = Mem[ $t4 + 4 ]
    #
    # Store double from coprocessor 1.
    sdc1 $f0, 0($t4)   #  Mem[ $t4 + 0 ] = $f0;  Mem[ $t4 + 4 ] = $f1
	

## Move Instructions
    # Move to coprocessor 1
    mtc1 $t0, $f0      # f0 = t0   Note that destination is *second* reg.
    #
    # Move from coprocessor 1.
    mfc1 $t0, $f0


## Data Type Conversion
    # Convert between floating-point and integer formats.
    # NOTE: Values don't convert automatically, need to use these insn.
    # To: s, d, w;  From: s, d, w
    #
    # cvt.TO.FROM fd, fs
    #
    cvt.d.w $f0, $f2     # $f0 = convert_from_int_to_double( $f2 )

## Setting Condition Codes
    # In preparation for a branch, set cond code based on FP comparison.
    # Compare:   fs COND ft
    # COND: eq, gt, lt, le, ge
    # FMT: s, d
    #
    # c.COND.FMT fs, ft
    # Sets condition code to true or false.
    # Condition is false if either operand is not a number.
    #
    c.lt.d $f0, $f2    # CC = $f0 < $f2
    bc1t TARG          # Branch if $f0 < $f2
    nop
    c.ge.d $f0, $f2    # CC = $f0 >= $f2
    bc1t TARG2          # Branch if $f0 < $f2
    nop
    # Reachable?


## FP Branches
    # Branch insn specifies whether CC register true or false.
    bc1t TARG
    nop
    #
    bc1f TARG
    nop

# executing every instruction PC increases by 4 and if there is no instruction after the last 
# line the there will be segmentation fault if you dont exit your program.
	li $v0, 10
	syscall
	

