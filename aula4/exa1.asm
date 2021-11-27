# Mapa de Registos
#  t0 - p
#  t1 - *p
	.data
	.eqv	print_string,4
	.eqv	read_string,8
	.eqv	SIZE,20
str1:	.asciiz "Introduza uma string: "
str:	.space	80
	.text
	.globl main
main:
	la	$a0,str1
	li	$v0,print_string
	syscall			# print_string(str1);
	la	$a0,str
	li	$a1,SIZE
	li	$v0,read_string
	syscall			# read_string(buf,length);
	la	$t0,str		# p = str;
while:	lb	$t1,0($t0)	# $t1 = *p
	beq	$t1,'\0',endw	# while( *p != '\0' ){
	sub	$t1,$t1,0x20	#
	sb	$t1,0($t0)	#   *p = *p - 'a' + 'A'; // 'a'-'A' = 0x20
	addiu	$t0,$t0,1	#   p++;
	j	while		# }
endw:
	la	$a0,str
	li	$v0,print_string
	syscall			# print_string(str);
	jr	$ra