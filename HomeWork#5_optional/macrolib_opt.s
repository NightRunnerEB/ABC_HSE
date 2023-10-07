.macro checkOverFlow

        bltz t4, negativeOverFlow
        bgtz t4, positiveOverFlow
        j continue
        
	negativeOverFlow:
	sub s4, s6, t4
	blt a0, s4, sumOver
	j continue
	
	positiveOverFlow:
	sub s4, s2, t4
	blt s4, a0, sumOver
	j continue

	sumOver:
        mv t5 a0
        print_str ("Произошло переполнение!\nСумма = ")
        print_int (t5)
        
        print_str ("\nКол-во просуммированных элементов = ")
        print_int (a1)
        exit
.end_macro

.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

.macro print_str (%x)
   .data
str:
   .asciz %x
   .text
   li a7, 4
   la a0, str
   ecall
.end_macro

.macro exit
    li a7, 10
    ecall
.end_macro

.macro read_int_a0
   li a7, 5
   ecall
.end_macro

.macro callFillArray
   jal fillArray
.end_macro

.macro callCalculateSum
   jal calculateSum
.end_macro

