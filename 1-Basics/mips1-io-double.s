#
#       Author: Aman Nidhi
#       Year: 2016
# 
#
.data
    myDouble:   .double 3.14
    zeroD:      .double 0.0

.text
####################### DOUBLE
# double: $v0 = 7 if read else 3 if print
# $f12 = double to be printed	
# double returned in $f0 and $f1 as double is 64bit long
# floating point registers doesnt have $zero kind of registers, So you need to..
# ..make one zero FP register. 

    lwc1 $f4, zeroD         # loading value from RAM to floating Point registers    
              
    li $v0, 7 
    syscall                 # reading and print user input double value. stored in %f0 and $f1
    li $v0, 3
    add.d $f12, $f0, $f4    # addition 
    syscall

      						# reading and print values defined in .data. RAM
    ldc1 $f2, myDouble  	# double is 64bits, myDouble stored in f2 and f3
    ldc1 $f0, zeroD
    li $v0, 3
    add.d $f12, $f2, $f0
    syscall

    # executing every instruction PC increases by 4 and if there is no instruction after the last 
    # line the there will be segmentation fault if you dont exit your program.
    li $v0, 10
    syscall


