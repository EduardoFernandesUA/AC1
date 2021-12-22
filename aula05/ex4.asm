# Mapa de Registos
#  t0 - *p
#  t1 - *(p+1)
#  t2 - 
#  t3 - 
#  t4 - houve_troca
#  t5 - p
#  t6 - pUltimo
#  t7 - aux

	.data
	.eqv	SIZE,10
	.eqv	FALSE,0
	.eqv	TRUE,1
str1:	.asciiz	"\nIntroduza numero: "
str2:	.asciiz	"\nConteudo do array: "
str3:	.asciiz	", "
	.align	2
lista:	.space	40
	.eqv	read_int,5
	.eqv	print_string,4
	.eqv	print_int10,1
	.text
	.globl	main
	
main:
	la	$t5,lista	# $t5 = lista
	li	$t6,SIZE	# $t6 = SIZE
	sll	$t6,$t6,2	# $t6 = SIZE * 4
	addu	$t6,$t5,$t6	# $t6 = lista + SIZE * 4
readw:	bgeu	$t5,$t6,ereadw	# while( p < pUltimo ) {
	la	$a0,str1
	li	$v0,print_string
	syscall			#   print_string(str1);
	li	$v0,read_int
	syscall
	sw	$v0,0($t5)	#   p = read_int();
	addiu	$t5,$t5,4	#   p++;
	j	readw   	# }
ereadw:
	la	$t5,lista
	li	$t6,SIZE	# $t6 = SIZE
	sll	$t6,$t6,2	# $t6 = SIZE * 4
	addu	$t6,$t5,$t6	# $t6 = lista + SIZE * 4
do:				# do {
	subu	$t6,$t6,4	#   $t6 = $t6 - 1
	li	$t4,FALSE	#   houve_troca = FALSE;
	la	$t5,lista	#   $t5 = lista
for:	bgeu	$t5,$t6,endfor	#   while( p < pUltimo ) {
	lw	$t0,0($t5)	#     $t0 = *p
	lw	$t1,4($t5)	#     $t1 = *(p+1)
if:	ble	$t0,$t1,endif	#     if( *p > *(i+1) ) {
	sw	$t0,4($t5)	#       *(p) = $t1
	sw	$t1,0($t5)	#       *(p+1) = $t0
	li	$t4,TRUE	#       houve_troca = TRUE;
endif:				#     }
	addiu	$t5,$t5,4	#     p++;
	j	for		#   }
endfor:
	bne	$t4,TRUE,enddo	# } while( houve_troca == TRUE );
	j	do
enddo:
	la	$a0,str2
	li	$v0,print_string
	syscall			# print_string(str2);
	la	$t5,lista
	li	$t6,SIZE	# $t6 = SIZE
	sll	$t6,$t6,2	# $t6 = SIZE * 4
	addu	$t6,$t5,$t6	# $t6 = lista + SIZE * 4
printw:
	bgeu	$t5,$t6,eprintw	# while( p < pUltimo ) {
	lw	$a0,0($t5)	#   $a0 = *p
	li	$v0,print_int10
	syscall			#   print_int10(*p);
	la	$a0,str3
	li	$v0,print_string
	syscall			#   print_string(", ");
	addiu	$t5,$t5,4	#   p++;
	j	printw		# }
eprintw:
	jr	$ra
	
	
