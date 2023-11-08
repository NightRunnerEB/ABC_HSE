.include "macro-syscalls.m"

.global strncpy
.text
strncpy:
    push(ra)
    push(a0)
    li t0 0
loop:
    beq     t0 a2 end   # Не равно ли кол-во скопированных элементов необходимому кол-ву элементов
    lb      t1 (a1)     # Загрузка символа из строки для копирования
    beqz    t1 end      # Конец строки
    sb      t1 (a0)
    addi    a0 a0 1     # Адрес символа в строке 1 увеличивается на 1
    addi    a1 a1 1     # Адрес символа в строке 2 увеличивается на 1
    addi    t0 t0 1     # Увеличиваем счётчик
    b       loop
end:
    sb      zero (a0)
    pop(a0)
    pop(ra)
    ret
