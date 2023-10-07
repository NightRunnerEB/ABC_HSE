.data
.align  2                       	# ������������ �� ������� �����
n:	.word	0
array:  .space  40

.include "macrolib.s"

.global main n array

.text
main:
        li      s2, 2147483647   	#max sum
	li      s6, -2147483648		#min sum
	li	s5, 2			#��������
	
        print_str ("n = ? ")	
        
        read_int_a0
        
        mv      t3 a0           	# ��������� ��������� � t3 (��� n)
        li      t4 0            	# ������������� ������� �������
        
        ble     t3 t4 fail      	# ������, ���� ������ 1
        li      t4 10           	# ������������ ������� �������
        bgt     t3 t4 fail      	# ������, ���� ����� ������ 10
        
        la	t4 n		 	# ����� n � t4
        sw	t3 (t4)		 	# �������� n � ������ �� ��������
        
        la      t0 array        	# ��������� �������� �������
        
        print_str("������� ��������:\n")
        
        jal fillArray			#����� ������������ ���������� �������
        
        jal calculateSum			#����� ������������ ������������ ��������� �������
        
        mv t5 a0
        print_str ("����� = ")
        print_int (t5)
        
        print_str ("\n���-�� ���������������� ��������� = ")
        print_int (a1)
        
        exit
        
fail:
        print_str ("incorrect n!\n")
        exit

