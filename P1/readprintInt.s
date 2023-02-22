.equ readInt,5
.equ printInt,6
.equ printStr,8
.equ printInt10,7

.data
print1: .asciiz "\nIntroduza um inteiro (sinal e modulo): "
print2: .asciiz "\nValor em base 10 (signed):"
print3: .asciiz "\nValor em base 2: "
print4: .asciiz "\nValor em base 16: "
print5: .asciiz "\nValor em base 10 (unsigned) :"
print6: .asciiz "\nValor em base 10 (unsigned), formatado: "
.text 
.globl main
main: 
li $t0,1
while : beq $t0,0,endWhile

	la $a0,print1
	li $v0,printStr
	syscall

	li $v0,readInt
	syscall

	la $a0,print2
	li $v0,printStr
	syscall

	move $a0,$t1
	li $v0,printInt10
	syscall

	
	la $a0,print3
	li $v0,printStr
	syscall

	move $a0,$t1
	li $a1,2
	li $v0,printInt
	syscall

	la $a0,print4
	li $v0,printStr
	syscall

	move $a0,$t1
	li $a1,16
	li $v0,printInt10
	syscall


	la $a0,print5
	li $v0,printStr
	syscall

	move $a0,$t1
	li $a1,10
	li $v0,printInt10
	syscall


	la $a0,print6
	li $v0,printStr
	syscall

	move $a0,$t1
	li $a1,0x00040002
	li $v0,printInt10
	syscall

	j while
endWhile:
li $v0,0
jr $ra
