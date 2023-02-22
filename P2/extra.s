.equ READ_CORE_TIMER,11
.equ RESET_CORE_TIMER,12
.equ PUT_CHAR,3
.equ PRINT_INT10,7
.equ INKEY,1

.data 
.text
.globl main
main: addiu $sp,$sp,-4
sw $ra,0($sp)

while:
	li $v0,INKEY
	syscall
	li $a0,1000
	move $a1,$v0
	jal timeDone
	move $a0,$v0
	li $v0,PRINT_INT10
	syscall
	
	li $a0,0x0A
	li $v0,PUT_CHAR
	syscall
j while
lw $ra,0($sp)
addiu $sp,$sp,4
li $v0,0
jr $ra

timeDone:
	li $t1,20000
	mul $t2,$t1,$a0
	li $t0,0 # retValue = 0
	if: bleu $a1,0,else
		li $v0,RESET_CORE_TIMER	
		syscall
		j endIf
	else:
		li $v0,READ_CORE_TIMER
		syscall
		innerIf: blt $v0,$t2,endInnerIf
			div $t0,$v0,$t1
		endInnerIf:
	endIf:
move $v0,$t0
jr $ra
