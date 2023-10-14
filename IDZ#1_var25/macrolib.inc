.macro print_array (%array, %str, %reg_size)
	 print_str (%str)
	 mv     a5 %reg_size		# Passing the array size as a argument
	 la	a2 %array        	# Put the pointer of the array
	 jal printArray			# call function printArray(int* arrPointer, int size) -> ()
.end_macro

.macro read_int_a0
   li a7, 5
   ecall
.end_macro

.macro print_str (%str)
   li a7, 4
   la a0, %str
   ecall
.end_macro

.macro exit
    li a7, 10
    ecall
.end_macro

.macro push(%reg)
	addi	sp, sp, -4
	sw	%reg, (sp)
.end_macro

.macro check_size (%reg)
        li      t4 0            	# Minimum array boundary     
        ble     %reg t4 fail      	# Error if less than 1
        li      t4 10           	# Maximum array bound
        bgt     %reg t4 fail      	# Error if number is greater than 10
.end_macro

.macro pop(%reg)
	lw	%reg, (sp)
	addi	sp, sp, 4
.end_macro

.macro put_to_array (%int)
	li      t2 %int
        sw      t2 (t0)     
        addi    t0 t0 4
.end_macro
