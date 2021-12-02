# Mapa de Registos
# i: t0
# v: t1
# &(val[0]): t2
	.data
	.eqv	print_int10,1
	.eqv	print_string,4
	.eqv	print_char,11
	.eqv	SIZE,8
	.eqv	SIZEd2,16	# (SIZE/2)*4
val:	.word	8,4,15,-1987,327,-9,27,16
str1:	.asciiz	"Result is: "
	.text
	.globl main
main:	li	$t0,0
	la	$t2,val
do:				# do {
	sll	$t1,$t0,2	#   t1 = i*4
	addu	$t3,$t1,$t2	#   t3 = val + i*4 = &val[i]
	lw	$t1,0($t3)	#   v = val[i];
	lw	$t4,SIZEd2($t3)	#   t3 = val[i+SIZE/2]
	sw	$t4,0($t3)	#   val[i] = t1
	sw	$t1,SIZEd2($t3)	#   val[i+SIZE/2] = t3
	addi	$t0,$t0,1
	bge	$t0,4,edo
	j	do	
edo:
	la	$a0,str1
	li	$v0,print_string
	syscall
	li	$t0,0
do2:	la	$t2,val
	sll	$t3,$t0,2
	addu	$t3,$t3,$t2
	lw	$a0,0($t3)
	li	$v0,print_int10
	syscall
	addi	$t0,$t0,1
	li	$a0,','
	li	$v0,print_char
	syscall
	bge	$t0,SIZE,edo2
	j	do2
edo2:
	jr	$ra
	
	
