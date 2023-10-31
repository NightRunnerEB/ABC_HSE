.data
minustwo:	.double -2
zero:		.double 0
half:		.double 0.5
minusfour:	.double 4
four:		.double -4
sevenhalf:	.double 7.5
.include "macrolib.inc"
.global test

.text
test:
	la      a5 minustwo
	li	t1 5
	
	fld     fa2, precision, t0	# Passing the parameter to the function
	write:
	fld     fa3 (a5)
	jal findSh			# Call function findSh(double parametr_X, double precision) -> (double result)
	print_sh(fa3)
	print_double(fa6)
	newline
	addi t1 t1 -1
	addi a5 a5 8
	bnez t1 write
	
	exit
	
