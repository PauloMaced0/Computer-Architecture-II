.equ RESET_CORE_TIMER,12
.equ READ_CORE_TIMER,11
.equ SFR_BASE_HI, 0xBF88
.equ PRINT_INT10,7
.equ TRISE, 0x6100
.equ PORTE, 0x6110
.equ LATE, 0x6120

.equ TRISB, 0x6040
.equ PORTB, 0x6050
.equ LATB, 0x6060

.data
.text
.globl main
main:

lui $t0, SFR_BASE_HI
lw $t2, TRISE($t0) # define as out 
andi $t2,$t2,0xFFE1
sw $t2,TRISE($t0)

lw $t2, TRISB($t0) # define as entry
andi $t2,$t2,0x0002
sw $t2,TRISB($t0)

li $t3,0 #Counter = 0

loop:
	lw $t5,PORTB($t0)
	andi $t5,$t5,0x0002
	srl $t5,$t5,1		
	
	li $a0,666 # 1.5HZ
	jal delay

	if: beqz $t5,else
	andi $t4,$t3,0x0008
	srl $t4,$t4,3		
	if1: bnez $t4,else1
		sll $t3,$t3,1	
		ori $t3,$t3,1
		j endif1
	else1:
		sll $t3,$t3,1	
	endif1:
		j endif
	else:
	andi $t4,$t3,0x0001

	if2: bnez $t4,else2
		srl $t3,$t3,1	
		ori $t3,$t3,8
		j endif2
	else2:
		srl $t3,$t3,1	
	endif2:
	
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
