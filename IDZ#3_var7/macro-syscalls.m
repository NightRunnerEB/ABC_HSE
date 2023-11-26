#===============================================================================
# Библиотека макроопределений для системных вызовов
#===============================================================================

#-------------------------------------------------------------------------------
# Печать содержимого заданного регистра как целого
.macro print_int (%x)
	push(a0)
	push(a7)
	li a7, 1
	mv a0, %x
	ecall
	pop(a7)
	pop(a0)
.end_macro
#-------------------------------------------------------------------------------
# Печать непосредственного целочисленного значения
.macro print_imm_int (%x)
	push(a0)
	li a7, 1
   	li a0, %x
   	ecall
   	pop(a0)
.end_macro

#-------------------------------------------------------------------------------
# Печать строковой константы, ограниченной нулевым символом
.macro print_str_reg (%reg)
   mv	a0 %reg
   li 	a7 4
   ecall
.end_macro

.macro print_str(%label)
   push (a0)
   la	a0 %label
   li 	a7 4
   ecall
   pop	(a0)
.end_macro

#-------------------------------------------------------------------------------
# Печать отдельного заданного символа
.macro print_char(%x)
   push(a0)
   li a7, 11
   li a0, %x
   ecall
   pop(a0)
.end_macro

#-------------------------------------------------------------------------------
# Печать отдельного заданного символа
.macro print_char_reg(%x)
   push(a0)
   push(a7)
   li a7, 11
   mv a0, %x
   ecall
   pop(a7)
   pop(a0)
.end_macro

#-------------------------------------------------------------------------------
# Печать перевода строки
.macro newline
   print_char('\n')
.end_macro

#-------------------------------------------------------------------------------
# Ввод целого числа с консоли в регистр a0
.macro read_int_a0
   li a7, 5
   ecall
.end_macro

#-------------------------------------------------------------------------------
# Ввод целого числа с консоли в указанный регистр, исключая регистр a0
.macro read_int(%x)
   push	(a0)
   li a7, 5
   ecall
   mv %x, a0
   pop	(a0)
.end_macro

#-------------------------------------------------------------------------------
# Ввод строки в буфер заданного размера с заменой перевода строки нулем
# %strbuf - адрес буфера
# %size - целая константа, ограничивающая размер вводимой строки
.macro str_get(%strbuf, %size)
    la      a0 %strbuf
    li      a1 %size
    li      a7 8
    ecall
    push(s0)
    push(s1)
    push(s2)
    li	s0 '\n'
    la	s1	%strbuf
next:
    lb	s2  (s1)
    beq s0	s2	replace
    addi s1 s1 1
    b	next
replace:
    sb	zero (s1)
    pop(s2)
    pop(s1)
    pop(s0)
.end_macro

#-------------------------------------------------------------------------------
.macro read_file(%descriptor, %start_heap, %cur_heap)
    mv a3 %descriptor
    mv a4 %start_heap
    mv a5 %cur_heap
    jal readFile			# Call function readFile(var descriptor, char* start_heap, char* cur_heap) -> (size_t size)
.end_macro

#-------------------------------------------------------------------------------
.macro write_file(%descriptor, %start_heap, %size)
    mv a3 %descriptor
    mv a4 %start_heap
    mv a5 %size
    jal writeFile			# Call function writeFile(var descriptor, char* start_heap, size_t size) -> ()
.end_macro

#-------------------------------------------------------------------------------
.macro write_file_console(%descriptor, %start_heap, %size)
    mv a3 %descriptor
    mv a4 %start_heap
    mv a5 %size
    jal writeFileAndConsole		# Call function writeFileAndConsole(var descriptor, char* start_heap, size_t size) -> ()
.end_macro
#-------------------------------------------------------------------------------
.macro which16(%number)
.data
A: .asciz "A"
B: .asciz "B"
C: .asciz "C"
D: .asciz "D"
E: .asciz "E"
F: .asciz "F"

.text
    mv t6 %number
    li s0 10 #A
    li s1 11 #B
    li s2 12 #C
    li s3 13 #D
    li s4 14 #E
    li s5 15 #F
    beq t6 s0 isA
    beq t6 s1 isB
    beq t6 s2 isC
    beq t6 s3 isD
    beq t6 s4 isE
    beq t6 s5 isF
    mv a0 t6
    j end
    isA:
    lb a0 A
    j end
    isB:
    lb a0 B
    j end
    isC:
    lb a0 C
    j end
    isD:
    lb a0 D
    j end
    isE:
    lb a0 E
    j end
    isF:
    lb a0 F
    end:
	
.end_macro

#-------------------------------------------------------------------------------
.macro is_vowel(%char)
.data 
vowels: .asciz "AaOoEeIiUuYy"
.text
	la t0 vowels
	li a0, 1
	mv a6 %char
	findLoop:
		lb t1, (t0)
		beqz t1, changeResult	# if didn't find - change result to 0
		beq t1, a6, end 	# if find - return 1
		addi t0, t0, 1
		j findLoop
	changeResult:
		li a0, 0
	end:
.end_macro

#-------------------------------------------------------------------------------
.macro userChoice
.data
choice_message: .asciz "Do you want to show results in console? Y/N\n"
error_message:  .asciz "Unknown input!! Try again!"

.text
	print_str(choice_message)
	li t0, 'Y'
	li t1, 'N'
	inputLoop:
	li a7, 12
	ecall
	beq a0, t0, endLoop
	beq a0, t1, endLoop
	newline
	print_str(error_message)
	newline
	j inputLoop
	endLoop:
	newline
.end_macro

#-------------------------------------------------------------------------------
# Открытие файла для чтения, записи, дополнения
.eqv READ_ONLY	0	# Открыть для чтения
.eqv WRITE_ONLY	1	# Открыть для записи
.macro open(%file_name, %opt)
    li   	a7 1024     	# Системный вызов открытия файла
    la     	a0 %file_name   # Имя открываемого файла
    li   	a1 %opt        	# Открыть для чтения (флаг = 0)
    ecall             		# Дескриптор файла в a0 или -1)
.end_macro

#-------------------------------------------------------------------------------
# Чтение информации из открытого файла
.macro read(%file_descriptor, %strbuf, %size)
    push(a1)
    push(a2)
    li   a7, 63       	# Системный вызов для чтения из файла
    mv   a0, %file_descriptor       # Дескриптор файла
    la   a1, %strbuf   	# Адрес буфера для читаемого текста
    li   a2, %size 		# Размер читаемой порции
    ecall             	# Чтение
    pop(a2)
    pop(a1)
.end_macro

#-------------------------------------------------------------------------------
# Чтение информации из открытого файла,
# когда адрес буфера в регистре
.macro read_addr_reg(%file_descriptor, %reg, %size)
    push(a1)
    push(a2)
    li   a7, 63       	# Системный вызов для чтения из файла
    mv   a0, %file_descriptor       # Дескриптор файла
    mv   a1, %reg   	# Адрес буфера для читаемого текста из регистра
    li   a2, %size 		# Размер читаемой порции
    ecall             	# Чтение
    pop(a2)
    pop(a1)
.end_macro

#-------------------------------------------------------------------------------
# Закрытие файла
.macro close(%file_descriptor)
    push(a0)
    li   a7, 57       # Системный вызов закрытия файла
    mv   a0, %file_descriptor  # Дескриптор файла
    ecall             # Закрытие файла
    pop(a0)
.end_macro

#-------------------------------------------------------------------------------
# Выделение области динамической памяти заданного размера
.macro allocate(%size)
    li a7, 9
    li a0, %size	# Размер блока памяти
    ecall
.end_macro

#-------------------------------------------------------------------------------
# Завершение программы
.macro exit
    li a7, 10
    ecall
.end_macro

#-------------------------------------------------------------------------------
# Сохранение заданного регистра на стеке
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

#-------------------------------------------------------------------------------
# Выталкивание значения с вершины стека в регистр
.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro
