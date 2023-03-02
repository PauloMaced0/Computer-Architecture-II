.equ RESET_CORE_TIMER,12
.equ READ_CORE_TIMER,11
.equ SFR_BASE_HI, 0xBF88
.equ PRINT_INT10,7
.equ TRISE, 0x6100
.equ PORTE, 0x6110
.equ LATE, 0x6120

.equ TRISD, 0x60C0
.equ PORTD, 0x60D0
.equ LATD, 0x60E0

.data
.text
.globl main
main:

lui $t0, SFR_BASE_HI
lw $t2, TRISE($t0) # define as out 
andi $t2,$t2,0xFFFE
sw $t2,TRISE($t0)

lw $t2, TRISD($t0) # define as out 
andi $t2,$t2,0xFFFE
sw $t2,TRISD($t0)

li $t3,0 # v= 0

loop:
	andi $t1,$t3,0x0001

	lw $t2,LATE($t0)
	andi $t2,$t2,0xFFFE
	or $t2,$t2,$t1
	sw $t2,LATE($t0)

	lw $t2,LATD($t0)
	andi $t2,$t2,0xFFFE
	or $t2,$t2,$t1
	sw $t2,LATD($t0)

	li $a0,500 # 2HZ
	jal delay
	
	xor $t3,$t3,1 # v ^= 1
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
