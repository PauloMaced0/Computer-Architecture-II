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
andi $t2,$t2,0xFFC3 # RE2-5
sw $t2,TRISE($t0)

lw $t2, TRISB($t0) # define as entry
andi $t2,$t2,0x000F # RB0-3
sw $t2,TRISB($t0)

loop:
	lw $t3,PORTB($t0)
	andi $t3,$t3,0x000F
	xor $t3,$t3,9 # RB0-3 ^ 1001 
	
	sll $t1,$t3,2 # shift 2 to access RE2-5
	lw $t2,LATE($t0)
	andi $t2,$t2,0xFFC3
	or $t2,$t2,$t1
	sw $t2,LATE($t0)

	j loop
	
li $v0,0
jr $ra
