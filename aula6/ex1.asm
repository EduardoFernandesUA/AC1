# Mapa de Reigistos
#  t0 - i

	.eqv	SIZE,3
	.data
array:	.word	str1,str2,str3
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz	"ponteiros"
	.text
	.globl main
main:
	li	$t0,0		# i = 0;
for:	bge	$t0,SIZE,endfor	# while( i<SIZE ){
	la	$t1,array	# $t1 = &array[0]
	sll	$t2,$t0,2	# $t2 = i * 4
	addu	$t2,$t2,$t1	# $t2 = &array[i]
	lw	$a0,0($t2)	# $a0 = array[i]
	li	$v0,4
	syscall			# print_string(array[i]);
	addi	$t0,$t0,1	# i++;
	j	for
endfor:
	jr	$ra