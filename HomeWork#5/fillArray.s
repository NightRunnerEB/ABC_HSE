.global fillArray

.include "macrolib.s"

.text
fillArray:   
        read_int_a0
        sw      a0 (t0)         # ������ ����� �� ������ � t0
        addi    t0 t0 4         # �������� ����� �� ������ ����� � ������
        addi    t3 t3 -1        # �������� ���������� ���������� ��������� �� 1
        bnez    t3 fillArray         # �� ����� �� ���-�� ���������� ��������� 

        print_str ("--------\n")

        lw	t3 n		 # ����� ��������� �������
        la      t0 array
        
        ret
