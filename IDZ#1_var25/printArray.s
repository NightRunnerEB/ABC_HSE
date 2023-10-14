.global printArray
.data
space:    	 .asciz " "

.include "macrolib.inc"

.text
printArray:
	 push(ra)
	 push(t4)			# Creating a local variable
	 loop:
	 lw 	t4 (a2)
	 addi	a2 a2 4			# Increase the address by the word size in bytes
         mv	a0 t4
         li	a7, 1
	 ecall
	 addi    a5 a5 -1        	# Reduce the number of remaining elements by 1
	 print_str (space)
         bnez    a5 loop         	# If there is more than 0 left, repeat the cycle      
         addi sp sp 4			# Freeing the stack cell where t4 is stored
         pop(ra)
         ret