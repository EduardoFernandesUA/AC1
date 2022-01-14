	.data
	.eqv SIZE,5
str2:	.asciiz "Introduza valores"
str3:	.asciiz "Variância:"
str4:	.asciiz "\n"
str5:	.asciiz "Desvio padrão:"
str6:	.asciiz "Variancia:"
	.align 3
str:	.space 40
	.eqv read_double,7
	.eqv print_double,3
	.eqv print_float,2
	.eqv print_string,4
k1:	.double 1.0
k2:	.float 0.0
k3:	.double 0.5
k4:	.double 0.0
k5:	.float 1.0
	.text
	.globl main
	
sqrt:
	l.d $f4,k1
	l.d $f2,k1
	li $t0,0
	l.d $f6,k4
	l.d $f10,k3
if:
	c.le.d $f12,$f6
	bc1t else
do:
	mov.d $f4,$f2
	
	div.d $f8,$f12,$f2
	add.d $f8,$f8,$f2
	mul.d $f2,$f10,$f8

	c.eq.d $f4,$f2
	bc1t enddo
	addi $t0,$t0,1
	blt $t0,25,do
enddo:	
	j endif
else:	
	mov.d $f2,$f6
endif:
	mov.d $f0,$f2
	jr $ra
	###
	
abst:	
	bgez $a0,endifabst
	mul $v0,$a0,-1 
	j endt
endifabst:
	move $v0,$a0
endt:
	jr $ra
	###

xtoy:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	jal abst
	
	l.s $f2,k5
	li $t0,0
	
f1:
	bge $t0,$v0,endf
if2:
	blez $a0,elsextoy
	mul.s $f2,$f2,$f12
	j endif2
elsextoy:
	div.s $f2,$f2,$f12
endif2:	
	addi $t0,$t0,1
	j f1
	
endf:
	mov.s $f0,$f2
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	###
	
average:
	move $t0,$a1
	l.d $f4,k4
	
for:	
	blez $t0,endfaverage
	
	addiu $t2,$t0,-1
	sll $t2,$t2,3
	addu $t2,$t2,$a0
	l.d $f6,0($t2)
	
	add.d $f4,$f6,$f4
	addiu $t0,$t0,-1
	
	j for
	
endfaverage:	
	mtc1.d $a1,$f2
	cvt.d.w $f2,$f2
	div.d $f0,$f4,$f2
	
	jr $ra
	###
	
var:
	addiu $sp,$sp,-28
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,12($sp)
	sw $s2,16($sp)
	s.s $f20,24($sp)
	
	move $s0,$a0
	move $s1,$a1
	
	jal average
	cvt.s.d $f20,$f0
	
	li $s2,0
	l.s $f4,k2
fvar:	
	bge $s2,$a1,endfvar
	
	sll $t1,$s2,3
	addu $t1,$t1,$s0
	l.d $f6,0($t1)
	cvt.s.d $f6,$f6
	
	sub.s $f12,$f6,$f20
	li $a0,2
	jal xtoy
	
	add.s $f4,$f4,$f0
	
	addi $s2,$s2,1
	j fvar
endfvar:	
	cvt.d.s $f4,$f4
	mtc1 $s1,$f6
	cvt.d.w $f6,$f6
	div.d $f0,$f4,$f6
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,12($sp)
	lw $s2,16($sp)
	l.s $f20,24($sp)
	addiu $sp,$sp,28
	jr $ra
	####
	
stdev:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	jal var
	mov.d $f12,$f0
	jal sqrt
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
main:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,str2
	li $v0,4
	syscall
	
	la $a0,str4
	li $v0,4
	syscall
	
	la $a0,str
	li $t1,SIZE
	addiu $t0,$t1,-1	
	sll $t0,$t0,3
	addu $t0,$t0,$a0	#ultimo endereço do array
	
fm1:
	bgt $a0,$t0,endfm1
	
	li $v0,7
	syscall
	mov.d $f2,$f0
	
	s.d $f2,0($a0)
	
	addi $a0,$a0,8
	j fm1
endfm1:
	la $a0,str6
	li $v0,4
	syscall
	
	la $a0,str4
	li $v0,4
	syscall
	
	la $a0,str
	li $a1,SIZE
	jal var		#calculo da variaçao
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	la $a0,str4
	li $v0,4
	syscall
	
	la $a0,str5
	li $v0,4
	syscall
	
	la $a0,str
	li $a1,SIZE
	jal stdev	#calculo do desvio
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra