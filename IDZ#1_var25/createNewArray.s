.global createNewArray

.include "macrolib.inc"

.text
createNewArray:    
	# a3 -> array B is stored
	# a4 -> array A is stored
	push(ra)
	push(t4)		 # Creating a local variable
	
        loopB:
        lw      t4 (a4)
        
        checkSign:              # Checks the sign and determines what needs to be done with the value
        bltz t4, negative
        bgtz t4, positive

	continue:
        sw      t4 (a3)		 # Writing a number to an address in array B
        addi    a4 a4 4	         # Moving to the next cell in the stack
        addi    a3 a3 4		 # Moving to the next cell in the stack
        addi    a5 a5 -1        # Reduce the number of remaining elements by 1
        bnez    a5 loopB        # If there is more than 0 left, repeat the cycle
        
        addi sp sp 4		 # Freeing the stack cell where t4 is stored
        pop(ra)
        ret
        
        negative:
	addi	t4 t4 5
	j continue
	positive:
	li	t4 2	
	j continue
        
        
