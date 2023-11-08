# Моделирование функции strncpy(char* destination, const char* source, size_t num) на C
.eqv     BUF_SIZE 100
.data
buf_input:     .space BUF_SIZE     	# Буфер для первой строки
buf_copy:       .space BUF_SIZE     	# Буфер для второй строки
empty_test_str: .asciz ""   		# Пустая тестовая строка
short_test_str: .asciz "I'm a short string:("     				 # Короткая тестовая строка
long_test_str:  .asciz "I'm a long string: one, two, free...one billion three hundred twenty-five million 53 thousand forty-two." # Длинная тестовая строка

.include "macro-syscalls.m"
.include "macro-string.m"

.globl main
.text
main:
    # Ввод строки в буфер
    print_str("Введите строку: ")
    la      a0 buf_input
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    print_str("Введите количество копируемых символов: ")
    read_int(a2)

    # Копирование строки в буфере
    strncpy(buf_copy, buf_input, a2)
    print_str("Результат копирования введённой строки: ")
    print_str_reg(a0)
    newline
    
    # Копирование пустой строки
    strncpy(buf_copy, empty_test_str, a2)
    print_str("Результат копирования пустой строки: ")
    print_str_reg(a0)
    newline
    
    # Копирование короткой строки
    strncpy(buf_copy, short_test_str, a2)
    print_str("Результат копирования короткой строки: ")
    print_str_reg(a0)
    newline
    
    # Копирование длинной строки
    strncpy(buf_copy, long_test_str, a2)
    print_str("Результат копирования длинной строки: ")
    print_str_reg(a0)

    exit
