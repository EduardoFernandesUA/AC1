# Mapa de Registos
#  t0 - i
#  t1 - j
#  t2 - *i
#  t3 - *j
#  t4 - lista+SIZE
#  t5 - lista+SIZE-1

	.data
	.eqv	SIZE,10
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
str1:	.asciiz	"\nIntroduza numero: "
str2:	.asciiz "\nConteudo do array: "
str3:	.asciiz	", "
	.align	2
lista:	.space	40
	.text
	.globl	main
	
main:
	la	$t0,lista	# i = lista;
	li	$t4,SIZE
	sll	$t4,$t4,2
	addu	$t4,$t4,$t0	# $t4 = lista + SIZE
rfor:	bge	$t0,$t4,erfor	# while( i < lista + SIZE ){
	la	$a0,str1
	li	$v0,print_string
	syscall			#   print_string(str1);
	li	$v0,read_int
	syscall
	sw	$v0,0($t0)	#   *i = read_int();
	addiu	$t0,$t0,4	#   i++;
	j	rfor		# }
erfor:
	la	$t0,lista	# i = lista
	li	$t4,SIZE
	sll	$t4,$t4,2
	addu	$t4,$t4,$t0	# $t4 = lista+SIZE
	subu	$t5,$t4,4	# $t5 = lista+SIZE-1
ifor:	bgeu	$t0,$t5,eifor	# while( i<lista+SIZE-1 ){
	addiu	$t1,$t0,4	#   j = i+1;
jfor:	bgeu	$t1,$t4,ejfor	#   while( j<lista+SIZE ){
	lw	$t2,0($t0)	#      $t2 = *i;
	lw	$t3,0($t1)	#      $t2 = *j;
if:	bleu	$t2,$t3,eif	#      if( *i > *j ){
	sw	$t3,0($t0)	#        *i = $t3
	sw	$t2,0($t1)	#        *j = $t2
eif:				#      }
	addiu	$t1,$t1,4	#      j++;
	j	jfor		#    }
ejfor:	
	addiu	$t0,$t0,4	#   i++;
	j	ifor		# }
eifor:
	la	$a0,str2
	li	$v0,print_string
	syscall
	la	$t0,lista
	li	$t4,SIZE
	sll	$t4,$t4,2
	addu	$t4,$t4,$t0	# $t4 = lista+SIZE
pfor:	bgeu	$t0,$t4,epfor	# while( i<lista+SIZE ){
	lw	$a0,0($t0)
	li	$v0,print_int10
	syscall			#   print_int10(*i);
	la	$a0,str3
	li	$v0,print_string
	syscall			#   print_string(str3);
	addiu	$t0,$t0,4	#   i++;
	j	pfor		# }
epfor:
	jr	$ra
	