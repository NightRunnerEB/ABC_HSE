.include "macro-syscalls.m"

.global strncpy
.text
strncpy:
    push(ra)
    push(a0)
    li t0 0
loop:
    beq     t0 a2 end   # �� ����� �� ���-�� ������������� ��������� ������������ ���-�� ���������
    lb      t1 (a1)     # �������� ������� �� ������ ��� �����������
    beqz    t1 end      # ����� ������
    sb      t1 (a0)
    addi    a0 a0 1     # ����� ������� � ������ 1 ������������� �� 1
    addi    a1 a1 1     # ����� ������� � ������ 2 ������������� �� 1
    addi    t0 t0 1     # ����������� �������
    b       loop
end:
    sb      zero (a0)
    pop(a0)
    pop(ra)
    ret
