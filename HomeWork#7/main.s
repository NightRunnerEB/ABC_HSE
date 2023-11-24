.include "macrolib.m"

.text 
main:
	clear(0x10)
	clear(0x11)
	li s0, 0 # borders [0,15]
	li s1, 20
	li s2, 0x10 # mode to the right block
	loopF:
		beq s0, s1, endLoop
		hex_print(s0,s2)
		sleep(1000)
		addi s0, s0, 1
		j loopF
	endLoop:
	clear(0x10)
	li s0, 0
	li s2, 0x11
	
	loopS:
		beq s0, s1, end
		hex_print(s0,s2)
		sleep(1000)
		addi s0, s0, 1
		j loopS	
	end:
	clear(0x11)
	exit