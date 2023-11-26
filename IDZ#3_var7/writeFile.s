.include "macro-syscalls.m"

.data
er_name_mes:    .asciz "Incorrect file name\n"

.global writeFile
.text
writeFile:
	# ������ ���������� � �������� ����
    push(ra)
    li s7 0
    li a7  64       		# ��������� ����� ��� ������ � ����
    writeNext:
    lb t2 (a4)
    is_vowel(t2)
    bnez a0 isHexadecimal
    mv   a0, a3 			# ���������� �����
    mv   a1, a4  			# ����� ������ ������������� ������
    li   a2, 1    			# ������ ������������ ������ �� ��������
    addi s7 s7 1
    ecall             			# ������ � ����
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
    addi s7 s7 4
    li   a2, 4    			# ������ ������������ ������ �� ��������
    ecall            			# ������ � ����
    
    j continue
