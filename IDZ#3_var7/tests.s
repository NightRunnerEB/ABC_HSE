.include "macro-syscalls.m"

.eqv    NAME_SIZE 256		# Размер буфера для имени файла
.eqv    TEXT_SIZE 512		# Размер буфера для текста

.data
autotest1_input:   .asciz "autotests\\autotest1_input.txt"
autotest1_out:	   .asciz "autotests\\autotest1_out.txt"

autotest2_input:   .asciz "autotests\\autotest2_input.txt"
autotest2_out:	   .asciz "autotests\\autotest2_out.txt"

autotest3_input:   .asciz "autotests\\autotest3_input.txt"
autotest3_out:	   .asciz "autotests\\autotest3_out.txt"

autotest4_input:   .asciz "autotests\\autotest4_input.txt"
autotest4_out:	   .asciz "autotests\\autotest4_out.txt"

waiting_message:   .asciz "Wait a few seconds, the program is processing the files...\n"
strbuf:		.space  TEXT_SIZE			# Буфер для читаемого текста

.global tests

.text
tests:
    push(ra)
#---------------------autotest1----------------------
    print_str(waiting_message)
    open(autotest1_input, READ_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла
    allocate(TEXT_SIZE)			# Результат хранится в a0
    mv 		s3, a0			# Сохранение адреса кучи в регистре
    mv 		t5, a0			# Сохранение изменяемого адреса кучи в регистре
    
    read_file(s0, s3, t5)
    mv t6 a1
    beqz t6 zeroSize1
    
    open(autotest1_out, WRITE_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла   
    write_file(s0, s3, t6)
    
    zeroSize1:
#---------------------autotest2----------------------
    open(autotest2_input, READ_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла
    allocate(TEXT_SIZE)			# Результат хранится в a0
    mv 		s3, a0			# Сохранение адреса кучи в регистре
    mv 		t5, a0			# Сохранение изменяемого адреса кучи в регистре
    
    read_file(s0, s3, t5)
    mv t6 a1
    beqz t6 zeroSize2
    
    open(autotest2_out, WRITE_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла   
    write_file(s0, s3, t6)
 
    zeroSize2:
#---------------------autotest3----------------------    
    open(autotest3_input, READ_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла
    allocate(TEXT_SIZE)			# Результат хранится в a0
    mv 		s3, a0			# Сохранение адреса кучи в регистре
    mv 		t5, a0			# Сохранение изменяемого адреса кучи в регистре
    
    read_file(s0, s3, t5)
    mv t6 a1
    beqz t6 zeroSize3
    
    open(autotest3_out, WRITE_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла   
    write_file(s0, s3, t6)
    zeroSize3:
#---------------------autotest4----------------------
    open(autotest4_input, READ_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла
    allocate(TEXT_SIZE)			# Результат хранится в a0
    mv 		s3, a0			# Сохранение адреса кучи в регистре
    mv 		t5, a0			# Сохранение изменяемого адреса кучи в регистре
    
    read_file(s0, s3, t5)
    mv t6 a1
    beqz t6 zeroSize4
    
    open(autotest4_out, WRITE_ONLY)
    mv   	s0 a0       		# Сохранение дескриптора файла   
    write_file(s0, s3, t6)
    pop(ra)
    ret
 
    zeroSize4:
    pop(ra)
    ret
