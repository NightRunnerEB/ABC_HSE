.macro read_double(%x)
   li a7 7
   ecall
   fmv.d %x, fa0
.end_macro

.macro read_int_a0
   li a7, 5
   ecall
.end_macro

.macro print_sh (%x)
.data
output_1:  .asciz "\nResult: \nSh("
output_2:  .asciz ") = "
.text
   print_str(output_1)
   print_double(%x)
   print_str(output_2)
.end_macro

.macro print_double (%reg)
   li a7 3
   fmv.d fa0 %reg
   ecall
.end_macro

.macro print_str (%str)
   li a7, 4
   la a0, %str
   ecall
.end_macro

.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

.macro newline
   print_char('\n')
.end_macro

.macro exit
    li a7, 10
    ecall
.end_macro

.macro push(%reg)
	addi	sp, sp, -4
	sw	%reg, (sp)
.end_macro

.macro pop(%reg)
	lw	%reg, (sp)
	addi	sp, sp, 4
.end_macro
