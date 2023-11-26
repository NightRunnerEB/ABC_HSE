.include "macro-syscalls.m"

.eqv    NAME_SIZE 256		# Размер буфера для имени файла
.eqv    TEXT_SIZE 512		# Размер буфера для текста

.data
autotests_message:  .asciz "Do you want to run an autotest? If yes, enter 1: "
read_file_message:  .asciz "Input path to file for reading: "
write_file_message: .asciz "Input path to file for writing: "
empty_file:     .asciz "The read file is empty!"
er_name_mes:    .asciz "Incorrect file name. Try again!\n"
done_message:      .asciz "File processing is complete!"
file_name:      .space	NAME_SIZE			# Имя читаемого файла
strbuf:		.space  TEXT_SIZE			# Буфер для читаемого текста

.text
main:
    li s2 1
    print_str(autotests_message)
    read_int_a0
    beq a0 s2 startAutoTests 
    userChoice
    mv s11 a0
    li s2 'Y'
    tryAgain:
    print_str(read_file_message)
    str_get(file_name, NAME_SIZE)
    open(file_name, READ_ONLY)
    li		t1 -1			# Проверка на корректное открытие
    beq		a0 t1 er_name		# Ошибка открытия файла
    mv   	s0 a0       		# Сохранение дескриптора файла
    allocate(TEXT_SIZE)			# Результат хранится в a0
    mv 		s3, a0			# Сохранение адреса кучи в регистре
    mv 		t5, a0			# Сохранение изменяемого адреса кучи в регистре
    
    read_file(s0, s3, t5)
    mv t6 a1
    beqz t6 zeroSize
    
    print_str(write_file_message)
    str_get(file_name, NAME_SIZE) 	# Ввод имени файла с консоли эмулятора
    open(file_name, WRITE_ONLY)
    li		t1 -1			# Проверка на корректное открытие
    beq		a0 t1 er_name		# Ошибка открытия файла
    mv   	s0 a0       		# Сохранение дескриптора файла
    
    bne s11 s2 withoutConsole
    write_file_console(s0, s3, t6)
    exit
    withoutConsole:
    write_file(s0, s3, t6)
    exit
    
    er_name:
    # Сообщение об ошибочном имени файла
    la		a0 er_name_mes
    li		a7 4
    ecall
    j tryAgain
    
    zeroSize:
    print_str(empty_file)
    exit
    
    startAutoTests:
    jal tests
    print_str(done_message)
    exit
