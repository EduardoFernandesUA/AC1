# Mapa de Registos
#  t1 - p
#  t2 - pultimo

	.data
	.eqv	print_string,4
	.eqv	print_char,11
	.eqv	SIZE,3
array:	.word	str1,str2,str3
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz	"ponteiros"
	.text
	.globl main
main:
	la	$t1,array	# p = array;
	li	$t0,SIZE
	sll	$t0,$t0,2
	addu	$t2,$t0,$t1	# pultimo = array + SIZE
for:	bgeu	$t1,$t2,efor	# while( p < pultimo ){
	lw	$a0,0($t1)
	li	$v0,print_string
	syscall
	li	$a0,'\n'
	li	$v0,print_char
	syscall
	addiu	$t1,$t1,4	#   p++;
	
	j	for		# }
efor:
	jr	$ra