.include "macro-syscalls.m"
.eqv    HEX_SIZE 4

.data
writeHex: .asciz "0x00"

.global replaceVowel

.text
replaceVowel:
        push(ra)
	la  a1 writeHex
	push(a1)
	li  t0 16
	li  t1 10
	div t4 a6 t0
	which16(t4)
	addi a1 a1 2
	blt a0 t1 add48
	continue:
	sb a0 (a1)
	
	rem t4 a6 t0
	which16(t4)
	addi a1 a1 1
	bgt t4 t1 skip
	addi a0 a0 48
	skip:
	sb a0 (a1)
	pop(a1)
	pop(ra)
	ret
	add48:
	addi a0 a0 48
	j continue

