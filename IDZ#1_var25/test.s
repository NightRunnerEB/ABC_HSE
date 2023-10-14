.data
n:	.word	10	       	 # Number of array elements entered
arrayA:  .space  40		 # We allocate space for the array 
newArrayA: .space 40
arrayB:  .space  12		 
newArrayB: .space 12
arrayC:  .space  16	
newArrayC: .space 16
arrayD:  .space  16	
newArrayD: .space 16
arrayE:  .space  32	
newArrayE: .space 32

outArrayA:	 .asciz  "Output of array elements A:\n"
outArrayNewA:	 .asciz  "\nOutput of elements of the new array A:\n"
outArrayB:	 .asciz  "\nOutput of array elements B:\n"
outArrayNewB:	 .asciz  "\nOutput of elements of the new array B:\n"
outArrayC:	 .asciz  "\nOutput of array elements C:\n"
outArrayNewC:	 .asciz  "\nOutput of elements of the new array C:\n"
outArrayD:	 .asciz  "\nOutput of array elements D:\n"
outArrayNewD:	 .asciz  "\nOutput of elements of the new array D:\n"
outArrayE:	 .asciz  "\nOutput of array elements E:\n"
outArrayNewE:	 .asciz  "\nOutput of elements of the new array E:\n"
skip:    	 .asciz "\n"

.include "macrolib.inc"
.global test

.text
test:
	la	t0 arrayA        # Put the pointer of the array
	li	t3 10
	put_to_array (87)
	put_to_array (-29)   
 	put_to_array (0)   
	put_to_array (6)     
	put_to_array (53)     
	put_to_array (9671)     
	put_to_array (-12)    
	put_to_array (-13751)    
	put_to_array (5871)
	put_to_array (-66)
       	print_str(skip)
       	
       	mv      a5 t3			# Passing the array size as a parameter
        la      a4 arrayA
        la      a3 newArrayA		# We pass the pointer of the array element as a argument
        jal createNewArray
        print_array (arrayA, outArrayA, t3)
        print_array (newArrayA, outArrayNewA, t3)  
        
        la 	t0 arrayB        # Put the pointer of the array
        li	t3 3
	put_to_array (-86514)
	put_to_array (29651) 
	put_to_array (615249)
       	print_str(skip)
       	
       	mv      a5 t3			# Passing the array size as a argument
        la      a4 arrayB		# We pass the pointer of the array element as a argument
        la      a3 newArrayB		# We pass the pointer of the array element as a argument
        jal createNewArray
       	print_array (arrayB, outArrayB, t3)
        print_array (newArrayB, outArrayNewB, t3)  
        
        la t0 arrayC        # Put the pointer of the array
        li	t3 4
	put_to_array (9999999)
	put_to_array (-1212121)   
	put_to_array (0)
	put_to_array (441257)
       	print_str(skip)
       	
        la      a4 arrayC
        mv      a5 t3			# Passing the array size as a argument
        la      a3 newArrayC		# We pass the pointer of the array element as a argument
        jal createNewArray
        print_array (arrayC, outArrayC, t3)
        print_array (newArrayC, outArrayNewC, t3)  
        
        la t0 arrayD        # Put the pointer of the array
        li	t3 4
	put_to_array (1)
	put_to_array (0)  
	put_to_array (-10)   
	put_to_array (0)
        print_str(skip)
        	
        la      a4 arrayD
        mv      a5 t3			# Passing the array size as a argument
        la      a3 newArrayD		# We pass the pointer of the array element as a argument
        jal createNewArray 
	print_array (arrayD, outArrayD, t3)
        print_array (newArrayD, outArrayNewD, t3)  
        
        la t0 arrayE        # Put the pointer of the array
        li	t3 8
	put_to_array (77)
	put_to_array (22)    
	put_to_array (-6)   
	put_to_array (1)    
	put_to_array (-1)   
	put_to_array (0)  
	put_to_array (-90)   
	put_to_array (3)
	print_str(skip)
        
        la      a4 arrayE
        mv      a5 t3			# Passing the array size as a argument
        la      a3 newArrayE		# We pass the pointer of the array element as a argument
        jal createNewArray
	print_array (arrayE, outArrayE, t3)
        print_array (newArrayE, outArrayNewE, t3) 
	
	exit
  
