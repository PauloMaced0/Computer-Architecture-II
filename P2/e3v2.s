.equ INKEY,1
.equ READ_CORE_TIMER,11
.equ RESET_CORE_TIMER,12
.equ PUT_CHAR,3
.equ PRINT_INT,6
.equ PRINT_STR,8

.data 
spaces: .asciiz "  "
.text
.globl main
main:
	addiu $sp,$sp,-20
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	li $s0,0 # counter10 = 0
	li $s1,0 # counter5 = 0
	li $s2,0 # counter1 = 0
	li $s3, 1
	
while: 


	li $v0,INKEY	
	syscall

	if1: bne $v0,0x52,endif1
		li $s3,0
	endif1:	

	if2: bne $v0,0x53,endif2
		li $s3,1
	endif2:	
	
	if: bnez $s3,endif

	move $a0,$s0
	li $a1,0x0005000A	
	li $v0,PRINT_INT
	syscall	

	la $a0,spaces
	li $v0,PRINT_STR
	syscall

	move $a0,$s1
	li $a1,0x0005000A	
	li $v0,PRINT_INT
	syscall	

	la $a0,spaces
	li $v0,PRINT_STR
	syscall

	move $a0,$s2
	li $a1,0x0005000A	
	li $v0,PRINT_INT
	syscall	

	li $a0,0x0D
	li $v0,PUT_CHAR
	syscall

	li $a0,100
	jal delay
	
	addiu $s0,$s0,1
	
	rem $t0,$s0,2
	if3: bnez $t0,endif3
		addiu $s1,$s1,1		
	endif3:

	rem $t0,$s0,10
	if4: bnez $t0,endif4
		addiu $s2,$s2,1		
	endif4:
	endif:

	j while
endwhile:
addiu $sp,$sp,20
lw $ra,0($sp)
lw $s0,4($sp)
lw $s1,8($sp)
lw $s2,12($sp)
lw $s3,16($sp)

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
                move $t1,$v0    # coreTimer -> $t1
                j while2 
        endwhile2:      
jr $ra
