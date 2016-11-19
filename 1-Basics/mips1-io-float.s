#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
    myFloat:    .float 	3.14
    zeroF:      .float 	0.0

.text
####################### FLOAT
# float : $v0 = 6 if read else 2 if print
# $f12 = float/double to be printed	
# float/double returned in $f0 as float is 32bit long
# floating point registers doesnt have $zero kind of registers, So you need to..
# ..make one zero FP register. 
                                
    lwc1 $f4, zeroF             # reading and print user input float value. stored in %f0
    
    li $v0, 6 
    syscall
    li $v0, 2
    add.s $f12, $f0, $f4
    syscall

    # executing every instruction PC increases by 4 and if there is no instruction after the last 
    # line the there will be segmentation fault if you dont exit your program.
    li $v0, 10
    syscall


