.data
sep:    .asciz  "--------\n"    
prompt: .asciz  "n = ? "
sumMessage:  .asciz  "Сумма = "
summaBreak:  .asciz  "Произошло переполнение!\n"
evenNumbers:  .asciz  "\nКол-во четных элементов: "
oddNumbers:  .asciz  "\nКол-во нечетных элементов: "
input:  .asciz  "Введите значения:\n"
error:  .asciz  "incorrect n!\n"  
skip:     .asciz "\n"
.align  2                       # Выравнивание на границу слова
n:	.word	0	       	 # Число введенных элементов массива
array:  .space  40
.text

in:
        li      t1, 0           # Сумма
        li	t5, 0		 # Кол-во четных чисел
        li	t6, 0		 # Кол-во нечетных чисел
        li      s2, 2147483647  #max sum
	li      s6, -2147483648	 #min sum
	li	s5, 2		 #Четность
        la 	a0, prompt      # Сообщение о вводе числа элементов
        li 	a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
        li      a7 5            # Системный вызов №5 — ввести десятичное число
        ecall
        mv      t3 a0           # Сохраняем результат в t3 (это n)
        li      t4 0            # Размер массива
        ble     t3 t4 fail      # Ошибка, если меньше 1
        li      t4 10           # Размер массива
        bgt     t3 t4 fail      # Ошибка, если число больше 10
        la	t4 n		 # Адрес n в t4
        sw	t3 (t4)		 # Загрузка n в память на хранение
        
        la      t0 array        # Указатель элемента массива
        la 	a0, input       # Сообщение о вводе значений массива
        li 	a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
 
fill:   
        li      a7 5            # Системный вызов №5 — ввести десятичное число
        ecall
        mv      t2 a0           # Сохраняем результат в t3 (это n)
        sw      t2 (t0)         # Запись числа по адресу в t0
        addi    t0 t0 4         # Увеличим адрес на размер слова в байтах
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 fill         # Не равно ли кол-во оставшихся элементов 

        la      a0 sep          # Выведем строку-разделитель
        li      a7 4
        ecall

        lw	t3 n		 # Число элементов массива
        la      t0 array
      
out:    
        lw      t4 (t0)
        rem	s3, t4, s5
        
        checkOverFlow:
        bltz t4, negativeOverFlow
        bgtz t4, positiveOverFlow
        
        checkEvenOrAOdd:
        beqz    s3, evenPlus
        bgtz	 s3, oddPlus
        continue:
        add     t1, t1, t4	 # Суммируем значения 
        addi    t0 t0 4
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 out          # Если осталось больше 0
        la 	 a0, sumMessage
        li 	 a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
        li 	 a7, 1           # Системный вызов №4 - вывод на консоль
        mv	 a0, t1
        ecall 		
        j evenAndOdd

        evenPlus:
        	addi t5, t5, 1
        	j continue
        oddPlus:
        	addi t6, t6, 1
        	j continue

negativeOverFlow:
	sub s4, s6, t4
	blt t1, s4, sumOver
	j checkEvenOrAOdd
positiveOverFlow:
	sub s4, s2, t4
	blt s4, t1, sumOver
        j checkEvenOrAOdd

sumOver:
        la 	 a0, summaBreak
        li 	 a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
        li 	 a7, 1           # Системный вызов №4 - вывод на консоль
        mv	 a0, t1
        ecall
        j evenAndOdd

fail:
        la 	a0, error       # Сообщение об ошибке ввода числа элементов массива
        li 	a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
        li      a7 10           # Остановка программы
        ecall
evenAndOdd:
        li 	a7, 4           # Системный вызов №4 - вывод на консоль
        la	 a0, evenNumbers
        ecall
        li 	 a7, 1           # Системный вызов №4 - вывод на консоль
        mv       a0, t5
        ecall
        li 	 a7, 4           # Системный вызов №4 - вывод на консоль
        la	 a0, oddNumbers
        ecall
        li 	 a7, 1           # Системный вызов №4 - вывод на консоль
        mv	 a0, t6
        ecall
        li      a7 10           # Остановка программы
        ecall
