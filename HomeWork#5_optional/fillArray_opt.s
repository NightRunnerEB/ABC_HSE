.global fillArray

.include "macrolib_opt.inc"

.text
fillArray:   
        push(ra)
        read_int_a0
        sw      a0 (t0)         # Запись числа по адресу в t0
        addi    t0 t0 4         # Увеличим адрес на размер слова в байтах
        addi    t3 t3 -1        # Уменьшим количество оставшихся элементов на 1
        bnez    t3 fillArray    # Не равно ли кол-во оставшихся элементов 

        print_str ("--------\n")

        lw	t3 n		 # Число элементов массива
        
        pop(ra)
        ret
