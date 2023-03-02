.equ RESET_CORE_TIMER,12
.equ READ_CORE_TIMER,11
.equ SFR_BASE_HI, 0xBF88
.equ TRISE, 0x6100
.equ PORTE, 0x6110
.equ LATE, 0x6120

.data
.text
.globl main
main:

lui $t0, SFR_BASE_HI
lw $t2, TRISE($t0) # define as out 
andi $t2,$t2,0xFFE1
sw $t2,TRISE($t0)

li $t3,0 #Counter = 0

loop:
	li $a0,250 # 4HZ
	jal delay
	if:beq $t3,15,else
		addiu $t3,$t3,1
		j endif
	else:
		li $t3,0	
	endif:
	sll $t1,$t3,1		
	lw $t2,LATE($t0)
	andi $t2,$t2,0xFFE1
	or $t2,$t2,$t1
	sw $t2,LATE($t0)

	j loop
	
li $v0,0
jr $ra

delay:
        move $t9,$a0
        li $t8,20000
        mul $t7,$t9,$t8
        li $v0,RESET_CORE_TIMER
        syscall
        li $t6,0
        while2: bgeu $t6,$t7,endwhile2
                li $v0,READ_CORE_TIMER
                syscall
                move $t6,$v0    # coreTimer -> $t1
                j while2
        endwhile2:
jr $ra
