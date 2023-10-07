.data
.align  2                       	# Выравнивание на границу слова
n:	.word	0
array:  .space  40

.include "macrolib.s"

.global main n array

.text
main:
        li      s2, 2147483647   	#max sum
	li      s6, -2147483648		#min sum
	li	s5, 2			#Четность
	
        print_str ("n = ? ")	
        
        read_int_a0
        
        mv      t3 a0           	# Сохраняем результат в t3 (это n)
        li      t4 0            	# Миниманальная граница массива
        
        ble     t3 t4 fail      	# Ошибка, если меньше 1
        li      t4 10           	# Максимальная граница массива
        bgt     t3 t4 fail      	# Ошибка, если число больше 10
        
        la	t4 n		 	# Адрес n в t4
        sw	t3 (t4)		 	# Загрузка n в память на хранение
        
        la      t0 array        	# Указатель элемента массива
        
        print_str("Введите значения:\n")
        
        jal fillArray			#Вызов подпрограммы заполнения массива
        
        jal calculateSum			#Вызов подпрограммы суммирования элементов массива
        
        mv t5 a0
        print_str ("Сумма = ")
        print_int (t5)
        
        print_str ("\nКол-во просуммированных элементов = ")
        print_int (a1)
        
        exit
        
fail:
        print_str ("incorrect n!\n")
        exit

