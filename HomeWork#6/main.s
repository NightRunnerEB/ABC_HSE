# ������������� ������� strncpy(char* destination, const char* source, size_t num) �� C
.eqv     BUF_SIZE 100
.data
buf_input:     .space BUF_SIZE     	# ����� ��� ������ ������
buf_copy:       .space BUF_SIZE     	# ����� ��� ������ ������
empty_test_str: .asciz ""   		# ������ �������� ������
short_test_str: .asciz "I'm a short string:("     				 # �������� �������� ������
long_test_str:  .asciz "I'm a long string: one, two, free...one billion three hundred twenty-five million 53 thousand forty-two." # ������� �������� ������

.include "macro-syscalls.m"
.include "macro-string.m"

.globl main
.text
main:
    # ���� ������ � �����
    print_str("������� ������: ")
    la      a0 buf_input
    li      a1 BUF_SIZE
    li      a7 8
    ecall
    print_str("������� ���������� ���������� ��������: ")
    read_int(a2)

    # ����������� ������ � ������
    strncpy(buf_copy, buf_input, a2)
    print_str("��������� ����������� �������� ������: ")
    print_str_reg(a0)
    newline
    
    # ����������� ������ ������
    strncpy(buf_copy, empty_test_str, a2)
    print_str("��������� ����������� ������ ������: ")
    print_str_reg(a0)
    newline
    
    # ����������� �������� ������
    strncpy(buf_copy, short_test_str, a2)
    print_str("��������� ����������� �������� ������: ")
    print_str_reg(a0)
    newline
    
    # ����������� ������� ������
    strncpy(buf_copy, long_test_str, a2)
    print_str("��������� ����������� ������� ������: ")
    print_str_reg(a0)

    exit
