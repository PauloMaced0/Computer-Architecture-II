.equ getChar, 2
.equ putChar, 3

.data 
.text
.globl main
main: 
do :	li $v0,getChar
	syscall
	add $v0,$v0,1
	move $t0,$v0
	move $a0,$v0
	li $v0,putChar
	syscall
while: bne $t0,0x0A,do
li $v0,0
jr $ra
