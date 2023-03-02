.equ SFR_BASE_HI, 0xBF88
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
andi $t2,$t2,0xFFFE
sw $t2,TRISE($t0)

lw $t2, TRISB($t0) # define as entry
ori $t2,$t2,0x0001
sw $t2,TRISB($t0)

loop:
	lw $t1,PORTB($t0)
	andi $t1,$t1,0x0001	
	xor $t1,$t1,0xFFFF # Implement complement
	
	lw $t2,LATE($t0)
	andi $t2,$t2,0xFFFE
	or $t2,$t2,$t1
	sw $t2,LATE($t0)

	j loop
	
li $v0,0
jr $ra
