.global calculateSum

.include "macrolib_opt.s"

.text
calculateSum:    
        li      a0  0           	# �����
        li      a1  0			#���-�� ���������������� ���������
        loop:
        lw      t4 (t0)
        checkOverFlow			#������ - �������� �� ������������
        
        continue:
        addi    a1 a1 1
        add     a0, a0, t4	 	# ��������� �������� 
        addi    t0 t0 4
        addi    t3 t3 -1        	# �������� ���������� ���������� ��������� �� 1
        bnez    t3 loop      	# ���� �������� ������ 0
        
        ret
