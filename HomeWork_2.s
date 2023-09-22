.data
    arg01:  .asciz "Ввести делимое "
    arg02:  .asciz "Ввести делитель: "
    remainder: .asciz "Остаток = "
    result: .asciz "Результат = "
    exception: .asciz "Нельзя делить на 0!"
    ln:     .asciz "\n"
.text
        la 	a0, arg01
        li 	a7, 4    
        ecall
        li      a7 5        
        ecall               
        mv      t0 a0   
        blt t0,zero, divisibleSign
        j continue1
        divisibleSign:
        	sub t0,zero,t0
        	li t3, -1 
	continue1:
        la 	a0, arg02   
        li 	a7, 4       
        ecall
        li      a7 5        
        ecall               
        mv      t1 a0
        blt t1, zero, dividerSign
        j continue2
        dividerSign:
        	sub t1, zero,t1
        	li t4, -1
        continue2:
        beqz t1,dividingByZero
      
	blt t0, t1, loopEnd
	loop:
		addi t2, t2,1
		sub t0,t0,t1
		bge t0, t1, loop
	loopEnd:

	blt t3, zero, changeRemainderSign
	j noChangeRemainder
	changeRemainderSign:
		sub, t0, zero, t0
		beqz t4, changeCountSign
		j end
	noChangeRemainder:
	blt t4, zero, changeCountSign
	j end
	changeCountSign:
		sub t2, zero, t2
	end:
		j printResult
dividingByZero:
	la a0,exception      
        li a7, 4           
        ecall
	j programClose
printResult:
	la a0, result
	li a7, 4
	ecall		
	mv a0, t2
	li a7, 1
	ecall
	
	la a0, ln
	li a7, 4
	ecall
	
	la a0, remainder
	li a7, 4
	ecall
		
	mv a0, t0
	li a7, 1
	ecall
programClose:
	li      a7 10
        ecall
