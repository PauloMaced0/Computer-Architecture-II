.equ RESET_CORE_TIMER,12
.equ READ_CORE_TIMER,11
.equ SFR_BASE_HI, 0xBF88
.equ PRINT_INT10,7
.equ PUT_CHAR,3

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
ori $t2,$t2,0x0002
sw $t2,TRISB($t0)

li $t3,1 #Counter = 1

loop:
	li $a0,333 # 3Hz
	jal delay

	lw $t1,PORTB($t0)	
	andi $t1,$t1,0x0002
	srl $t1,$t1,1
	
	sll $t4,$t3,1		
	lw $t2,LATE($t0)
	andi $t2,$t2,0xFFE1
	or $t2,$t2,$t4
	sw $t2,LATE($t0)

	ifkey: bne $t1,1,elsekey
		if1: beq $t3,0x0008,else1
			sll $t3,$t3,1						
			j endif1
		else1:
			li $t3,1
		endif1:
		j endifkey
	elsekey:
		if2: beq $t3,1,else2
			srl $t3,$t3,1						
			j endif2
		else2:
			li $t3,8
		endif2:
	endifkey:
	
endif:
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
