# Mapa de Registos
#  t0 - i
#  t1 - argc
#  t2 - argv
#
	.data
	.eqv	print_int10,1
	.eqv	print_string,4
str1:	.asciiz	"Nr. de parametros: "
str2:	.asciiz	"\nP"
str3:	.asciiz	": "
	.text
	.globl main
main:	move	$t1,$a0
	move	$t2,$a1
	la	$a0,str1
	li	$v0,print_string
	syscall
	move	$a0,$t1
	li	$v0,print_int10
	syscall
	li	$t0,0
for:	bgeu	$t0,$t1,efor	# while( i<argc ){
	la	$a0,str2
	li	$v0,print_string
	syscall
	move	$a0,$t0
	li	$v0,print_int10
	syscall
	la	$a0,str3
	li	$v0,print_string
	syscall
	sll	$a0,$t0,2
	addu	$a0,$a0,$t2
	lw	$a0,0($a0)
	li	$v0,print_string
	syscall
	addi	$t0,$t0,1
	j	for
efor:	jr	$ra