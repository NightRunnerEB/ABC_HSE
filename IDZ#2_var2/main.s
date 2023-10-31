.data
precision:	.double 0.001
input:		.asciz "Enter the value of x to construct a power series: "
doTest:		.asciz "Do an automated test? If Yes, enter 1, otherwise 0:\n"
tryAgain:  	.asciz "\nRun the program again? If Yes, enter 1, otherwise 0:\n"
.include "macrolib.inc"
.global precision

# We need to find sh(x) = (e^x - e^?x)/2
# Calculates e^x as an infinite sum: 1 + x/1! + x^2/2! + ...
.text
main:
	print_str (doTest)		# We ask whether it is necessary to conduct an automatic test?
	read_int_a0
	bnez a0 test			# If input is 1, then test	
	
	print_str(input)
	
	read_double(fa3)		# Save the entered value of x in the register fa3
	fld      fa2, precision, t0	# Passing the parameter to the function
	jal findSh			# Call function findSh(double parametr_X, double precision) -> (double result)
	
	print_sh(fa3)			# Output the result
	print_double(fa6)
	
	print_str(tryAgain)		# Repeat the program?
	read_int_a0
	bnez a0 main
	
	exit
	
