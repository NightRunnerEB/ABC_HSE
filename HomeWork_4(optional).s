.data
message:    .asciz  "The maximum argument is "    
.text
        la 	a0, message
        li 	a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
	li	s1, 1		#результат произведения
	li	s2, 1		#копия a0 + 1
	li	a0, 1		#макс значение аргумента
        jal     fact
        li      a7 1
        ecall
        li      a7 10
        ecall
# Подпрограмма вычисления факториала
fact:   
	addi    sp sp -4        ## Запасаем ячейку в стеке
        sw      ra (sp)         ## Сохраняем ra
        
  addi	s2, s2, 1
	mulhu	t1, s1, s2
	bnez	t1, overFlow
	mul	s1, s1, s2
	addi	a0, a0, 1
	jal	fact
overFlow:
        lw      ra (sp)         ## Восстанавливаем ra
        addi    sp sp 4         ## Восстанавливаем вершину стека
        ret
        
