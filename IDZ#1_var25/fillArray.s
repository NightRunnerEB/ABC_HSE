.include "macrolib.inc"

.global fillArrayA
.data
sep:    	 .asciz  "--------\n"  

.text
fillArrayA:   
        push(ra)
        loopA:
        read_int_a0
        sw      a0 (a3)         	# Writing a number to an address in t0
        addi    a3 a3 4         	# Increase the address by the word size in bytes
        addi    a5 a5 -1        	# Reduce the number of remaining elements by 1
        bnez    a5 loopA         	# If there is more than 0 left, repeat the cycle
        print_str (sep)
        pop(ra)
        ret
