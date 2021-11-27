# Mapa de Registos
#  t0 - 
#  t1 - p
#  t2 - pultimo

	.eqv	SIZE,3
	.data
array:	.word	str1,str2,str3
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz	"ponteiros"
	.text
	.globl main
main:
	la	$t1,array	# p = array
	li	$t0,SIZE
	sll	$t0,$t0,2
	addu	$t2,$t0,$t1	# pultimo = array + SIZE
for:	bgeu	$t1,$t2,endfor	# while( p<pultimo ){
	lw	$a0,0($t1)	#   $a0 = *p
	li	$v0,4
	syscall			#   print_string(*p);
	addiu	$t1,$t1,4	#   p++;
	j	for		# }
endfor:
	jr	$ra