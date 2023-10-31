.data
minus:	.double -1
one:	.double 1
two:	.double 2

.include "macrolib.inc"
.global findSh
.text
findSh:
	push(ra)
	addi 	sp, sp, -8 		#Created a local variable "one"
        fld    ft0, one, t0
        fsd	ft0, (sp)
        
        addi 	sp, sp, -8 		#Created a local variable "two"
        fld    ft0, two, t0
        fsd	ft0, (sp)
        
	fld     ft5, 8(sp)		# n
	fld     ft3, (sp)		
	fsub.d  ft4, ft4, ft4    	# n = 0
	flt.d   t2 fa3 ft4
	bnez    t2 convertMinus
	fld     ft8 one t0
	continue:
	fld     ft0, 8(sp)		# here will be e_1 = 1
	fld	fa5, 8(sp)
	loop1:
	fadd.d  ft4 ft4 fa5    		# n = n + 1
	
	fdiv.d	ft5 ft5 ft4		# Divide by n!
	fmul.d  ft5 ft5 fa3		# x = x * x
	fadd.d	ft0 ft0 ft5		# Increasing e_1
	
	flt.d   t0, ft5, fa2		# An increase of less than 0.001?
	beqz    t0, loop1
	
	fdiv.d  ft2 fa5 ft0		# here will be e_2
	fsub.d  fa6 ft0 ft2
	fdiv.d	fa6 fa6 ft3		# find sh(x)
	fmul.d	fa6 fa6 ft8
	
	fmul.d	 fa3 fa3 ft8
	
	addi sp sp 16
	pop(ra)
	ret
	
	convertMinus:
	fld      ft8 minus t0
	fmul.d	 fa3 fa3 ft8
	j continue
