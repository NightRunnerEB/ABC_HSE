.global calculateSum

.include "macrolib_opt.inc"

.text
calculateSum:    
        push(ra)
        li      a0  0           	# Сумма
        li      a1  0			#кол-во просуммированных элементов
        loop:
        lw      t4 (t0)
        checkOverFlow			#Макрос - проверка на переполнение
        
        continue:
        addi    a1 a1 1
        add     a0, a0, t4	 	# Суммируем значения 
        addi    t0 t0 4
        addi    t3 t3 -1        	# Уменьшим количество оставшихся элементов на 1
        bnez    t3 loop      	# Если осталось больше 0
        
        pop(ra)
        ret
