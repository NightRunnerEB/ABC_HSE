.include "macrolib.m"

.global getHex

.data
zeroMy: .byte 0x3f 
one: .byte 0x06
two: .byte 0x5b
three: .byte 0x4f
four: .byte 0x66
five: .byte  0x6d
six: .byte 0x7d
seven: .byte 0x07
eight: .byte 0x7f
nine: .byte 0x6f
ten: .byte 0x77
eleven: .byte 0x7f
twelve: .byte 0x39
thirteen: .byte 0x3f
fourteen: .byte 0x79
fifteen: .byte 0x71
point: .byte 0x80
end:


.text 
getHex:
	push(ra)
	
	lui t5, 0xffff0
	add t5, t5, a1
	la t0, zeroMy
	lb t1, point
	li t2, 0xf
	mv t3, a0
	
	and t3, t3, t2
	add t0, t0, t3
	lb t4, (t0)
	bne a0, t3, getPoint
	j noPoint
	getPoint:
	or t4, t4, t1
	noPoint:
	sb t4, (t5)
	
	pop(ra)
	ret