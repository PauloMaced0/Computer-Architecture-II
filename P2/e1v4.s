# 1Hz frequency version
.equ READ_CORE_TIMER,11
.equ RESET_CORE_TIMER,12
.equ PUT_CHAR,3
.equ PRINT_INT,6

.data 
.text
.globl main
main: li $t0,0 # counter = 0
while: 
	li $t1,0
	li $v0,RESET_CORE_TIMER
	syscall
		
	while2: bgeu $t1,20000000,endwhile2
		li $v0,READ_CORE_TIMER
		syscall
		move $t1,$v0	# coreTimer -> $t1
		j while2
	endwhile2:	
	move $a0,$t0
	li $a1,0x4000A	
	li $v0,PRINT_INT
	syscall	

	addiu $t0,$t0,1
	li $a0,0x0D
	li $v0,PUT_CHAR
	syscall
	
	j while
endwhile:
li $v0,0
jr $ra
