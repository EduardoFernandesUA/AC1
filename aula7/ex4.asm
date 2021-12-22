# Mapa de Registos
#
	.data
	.eqv	print_string,4
str1:	.asciiz	"Arquiteture de "
str2:	.space	50
str3:	.asciiz	"\n"
str4:	.asciiz	"Computadores I"
	.text
	.globl main

main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str2
	la	$a1,str1
	jal	strcpy
	la	$a0,str2
	li	$v0,print_string
	syscall
	la	$a0,str3
	li	$v0,print_string
	syscall
	la	$a0,str2
	la	$a1,str4
	jal	strcat
	la	$a0,str2
	li	$v0,print_string
	syscall
	li	$v0,0
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra








#################################################
strcpy:				# char *strcpy(char *dst, char *src) {
	li	$t0,0
do:				# do {
	addu	$t1,$t0,$a1
	lb	$t2,0($t1)	#   temp = src[i]
	addu	$t1,$t0,$a0
	sb	$t2,0($t1)
	beq	$t2,'\0',edo
	addi	$t0,$t0,1
	j	do
edo:
	move	$v0,$a0
	jr	$ra


#################################################
strcat:				# char *strcat(char *dst, char *src)
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	move	$t0,$a0
	move	$t2,$a0
	move	$t3,$a1
strcat_w:
	lb	$t1,0($t0)
	beq	$t1,'\0',strcat_ew
	addiu	$t0,$t0,1
	j	strcat_w
strcat_ew:
	move	$a0,$t0
	move	$a1,$t3
	jal	strcpy
	move	$v0,$t2
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra















