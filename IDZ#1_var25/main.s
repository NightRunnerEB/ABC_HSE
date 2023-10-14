.data  
doTest:		 .asciz  "Do an automated test? If Yes, enter 1, otherwise 0:\n"
prompt: 	 .asciz  "\nEnter the array size from 1 to 10: "
input: 		 .asciz  "Enter the values of the array elements:\n"
outArrayA:	 .asciz  "Output of array elements A:\n"
outArrayB:	 .asciz  "\nThe output of array elements B:\n"
createB: 	 .asciz  "Array B has been successfully created!\n"
error: 		 .asciz  "Incorrect n!\nEnter the value again: "  
.align  2                       # Alignment to the word boundary
n:	.word	0	       	 # Number of array elements entered
arrayA:  .space  40		 # We allocate space for the array
arrayB:  .space  40

.include "macrolib.inc"
.global main n arrayA arrayB

.text
main:
	print_str (doTest)		# We ask whether it is necessary to conduct an automatic test?
	read_int_a0
	bnez a0 test			# If input is 1, then test	
	print_str (prompt)
	
	tryAgain:
        read_int_a0			    
        mv      t3 a0           	# Saving the result in t3 (this is n)
        check_size (t3)			
            
        print_str(input)
        
        mv      a5 t3			# Passing the array size as a argument
        la      a3 arrayA 		# We pass the pointer of the array element as a argument
        jal fillArrayA			# call function fillArrayA(int* arrPointer, int size) -> ()
        
        la      a4 arrayA		# We pass the pointer of the array element as a argument
        la      a3 arrayB		# We pass the pointer of the array element as a argument
        mv      a5 t3			# Passing the array size as a argument
        jal createNewArray		# call function createNewArray(int* arrPointer_A, int* arrPointer_B, int size) -> ()
       
        print_str (createB)		
        print_array (arrayA, outArrayA, t3)	# Output the elements of array A
        print_array (arrayB, outArrayB, t3)	# Output the elements of array B
        
        exit					# End the program
        
fail:
        print_str (error)			# A message about an incorrect entered size
        j tryAgain				# Repeat entering the array size value

