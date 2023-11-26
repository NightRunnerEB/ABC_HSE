.include "macro-syscalls.m"

.eqv    MAX_SIZE 10240
.eqv    TEXT_SIZE 512

.data
er_read_mes:    .asciz "Incorrect read operation\n"

.global readFile
.text
readFile:
    push(ra)
    li		t1 -1			# �������� �� ���������� ������
    li		t4, TEXT_SIZE		# ���������� ��������� ��� ���������
    li		t5  MAX_SIZE
    mv		a1, zero		# ��������� ��������� ����� ������������ ������
    read_loop:
    read_addr_reg(a3, a5, TEXT_SIZE)
    # �������� �� ���������� ������
    beq		a0 t1 er_read		# ������ ������
    mv   	t2 a0       		# ���������� ����� ������
    add 	a1, a1, t2		# ������ ������ ������������� �� ����������� ������
    beq  	a1 t5 end_loop
    bne		t2 t4 end_loop

    allocate(TEXT_SIZE)			# ����� ��������� ����� � ���������
    add		a5 a5 t2		# ����� ��� ������ ��������� �� ������ ������
    b read_loop				# ��������� ��������� ������ ������ �� �����
end_loop:
    close(a3)				# �������� �����
    # ��������� ���� � ����� ����������� ������
    mv	t0 a4		# ����� ������ � ����
    add t0 t0 a1	# ����� ���������� ������������ �������
    addi t0 t0 1	# ����� ��� ����
    sb	zero (t0)	# ������ ���� � ����� ������
    pop(ra)
    ret
er_read:
    # ��������� �� ��������� ������
    la		a0 er_read_mes
    li		a7 4
    ecall
    exit
