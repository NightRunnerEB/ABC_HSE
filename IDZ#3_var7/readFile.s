.include "macro-syscalls.m"

.eqv    MAX_SIZE 10240
.eqv    TEXT_SIZE 512

.data
er_read_mes:    .asciz "Incorrect read operation\n"

.global readFile
.text
readFile:
    push(ra)
    li		t1 -1			# Проверка на корректное чтение
    li		t4, TEXT_SIZE		# Сохранение константы для обработки
    li		t5  MAX_SIZE
    mv		a1, zero		# Установка начальной длины прочитанного текста
    read_loop:
    read_addr_reg(a3, a5, TEXT_SIZE)
    # Проверка на корректное чтение
    beq		a0 t1 er_read		# Ошибка чтения
    mv   	t2 a0       		# Сохранение длины текста
    add 	a1, a1, t2		# Размер текста увеличивается на прочитанную порцию
    beq  	a1 t5 end_loop
    bne		t2 t4 end_loop

    allocate(TEXT_SIZE)			# Иначе расширить буфер и повторить
    add		a5 a5 t2		# Адрес для чтения смещается на размер порции
    b read_loop				# Обработка следующей порции текста из файла
end_loop:
    close(a3)				# Закрытие файла
    # Установка нуля в конце прочитанной строки
    mv	t0 a4		# Адрес буфера в куче
    add t0 t0 a1	# Адрес последнего прочитанного символа
    addi t0 t0 1	# Место для нуля
    sb	zero (t0)	# Запись нуля в конец текста
    pop(ra)
    ret
er_read:
    # Сообщение об ошибочном чтении
    la		a0 er_read_mes
    li		a7 4
    ecall
    exit
