.include "macro-syscalls.m"

.data
er_name_mes:    .asciz "Incorrect file name\n"
writeCons:   .asciz "\nText processing result:\n" 

.global writeFileAndConsole
.text
writeFileAndConsole:
	# ������ ���������� � �������� ����
    push(ra)
    print_str(writeCons)
    li a7  64       		# ��������� ����� ��� ������ � ����
    writeNext:
    lb t2 (a4)
    is_vowel(t2)
    bnez a0 isHexadecimal
    mv   a0, a3 			# ���������� �����
    mv   a1, a4  			# ����� ������ ������������� ������
    li   a2, 1    			# ������ ������������ ������ �� ��������
    ecall             			# ������ � ����
    print_char_reg(t2)
    continue:
    addi a5 a5 -1
    addi a4 a4 1
    bnez a5 writeNext
    pop(ra)
    close(a3)
    mv a0 s7
    ret
    isHexadecimal:
    mv   a6 t2
    jal replaceVowel			# return a1 - 16-�� ������
    mv   a0, a3 			# ���������� �����
    li   a2, 4    			# ������ ������������ ������ �� ��������
    ecall            			# ������ � ����
    li s8 4
    loopCons:
    lb a2 (a1)
    print_char_reg(a2)
    addi a1 a1 1
    addi s8 s8 -1
    bnez s8 loopCons
    
    j continue
