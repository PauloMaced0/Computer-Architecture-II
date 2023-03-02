# USING INT1
.equ SFR_BASE_HI, 0xBF88
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

lw $t2, TRISD($t0) # define as entry
ori $t2,$t2,0x0100
sw $t2,TRISD($t0)

loop:
	lw $t1,PORTD($t0)
	andi $t1,$t1,0x0100	
	xor $t1,$t1,0xFFFF # complement
	
	lw $t2,LATE($t0)
	andi $t2,$t2,0xFFFE
	srl $t1,$t1,8 # Bit de saída 0
	or $t2,$t2,$t1
	sw $t2,LATE($t0)

	j loop
	
li $v0,0
jr $ra
