.equ RESET_CORE_TIMER,12
.equ READ_CORE_TIMER,11
.equ PRINT_INT,7

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
andi $t2,$t2,0xFFE1
sw $t2,TRISE($t0)

lw $t2,TRISB($t0)
ori $t2,$t2,0x0008 # define as entry
sw $t2,TRISB($t0)

li $t3,0 #Counter = 0

loop:
	lw $t1,PORTB($t0)
	andi $t1,$t1,0x0008
	srl $t1,$t1,3
	
	move $a0,$t1
	li $v0,PRINT_INT
	syscall
	
	li $a0,500 # 2HZ
	jal delay

	ifkey:bne $t1,1,elsekey
		if:bgt $t3,15,else
			addi $t3,$t3,1
			j endif
		else:
			li $t3,0	
		endif:
			j endifkey
	elsekey:
		if1:beq $t3,0,else1
			addi $t3,$t3,-1
			j endif1
		else1:
			li $t3,15
		endif1:
	endifkey:

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
