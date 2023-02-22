.equ READ_CORE_TIMER,11
.equ RESET_CORE_TIMER,12
.equ PUT_CHAR,3
.equ PRINT_INT,6

.data 
.text
.globl main
main:	addiu $sp,$sp,-4	
	sw $ra,0($sp) 
	li $t0,0 # counter = 0
while: 
	li $a0,500# delay(unsigned int ms) 1000 ms -> 1 second 
	jal delay

	move $a0,$t0
	li $a1,0x0004000A	
	li $v0,PRINT_INT
	syscall	

	addiu $t0,$t0,1

	li $a0,0x0D
	li $v0,PUT_CHAR
	syscall
	
	j while
endwhile:
lw $ra,0($sp) 
addiu $sp,$sp,4	
li $v0,0
jr $ra

delay:
	move $t4,$a0
	li $t3,20000
	mul $t2,$t4,$t3
	li $v0,RESET_CORE_TIMER
	syscall
	li $t1,0
	while2: bgeu $t1,$t2,endwhile2
		li $v0,READ_CORE_TIMER
		syscall
		move $t1,$v0	# coreTimer -> $t1
		j while2 
	endwhile2:	
jr $ra
