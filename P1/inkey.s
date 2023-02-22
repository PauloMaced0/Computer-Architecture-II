.equ inkey, 1
.equ putChar, 3

.data
.text
.globl main
main:
do :    
	li $v0,inkey
	syscall
        move $t0,$v0
if: 	beq $t0,0x0,else
        move $a0,$v0
        li $v0,putChar
        syscall
	j endIf
else:	
	li $a0,0x2E
        li $v0,putChar
        syscall
endIf:
while: bne $t0,0x0A,do
li $v0,0
jr $ra

