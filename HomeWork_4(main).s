.data
message:    .asciz  "The maximum argument is "    
.text
        la 	a0, message
        li 	a7, 4           # Системный вызов №4 - вывод на консоль
        ecall
        jal     fact
        li      a7 1	
        ecall                
        li      a7 10
        ecall
fact:   
	li	s1, 1		#результат произведения
	li	a0, 1		#макс значение аргумента
	loop:
	addi	a0, a0, 1
	mulhu	t1, s1, a0
	bnez	t1, overFlow
        mul	s1, s1, a0
        j loop
overFlow:
	addi	a0, a0, -1
	ret
