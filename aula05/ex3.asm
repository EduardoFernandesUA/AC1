# Mapa de Registos
#  t0 - p
#  t1 - *p
#  t2 - lista+Size
#  t3 - 
#  t4 - houve_troca
#  t5 - i
#  t6 - lista
#  t7 - lista + i

	.data
	.eqv	SIZE,10
	.eqv	FALSE,0
	.eqv	TRUE,1
str1:	.asciiz	"\nIntroduza um numero: "
str2:	.asciiz	"\nConteudo do array:\n"
str3:	.asciiz	"; "
	.align	2
lista:	.space	40		# SIZE * 4
	.eqv	read_int,5
	.eqv	print_string,4
	.eqv	print_int10,1
	.text
	.globl main
	
main:
	la	$t0,lista	# p = lista
	li	$t2,SIZE	
	sll	$t2,$t2,2
	addu	$t2,$t2,$t0	# $t2 = lista + SIZE
readwhile:
	bgeu	$t0,$t2,readend	# while( p < p+SIZE ) {
	la	$a0,str1
	li	$v0,print_string
	syscall			#   print_string(str1);
	li	$v0,read_int
	syscall
	sw	$v0,0($t0)	#   *p = read_int()
	addi	$t0,$t0,4	#   p++;
	j	readwhile	# }
readend:
	
	la	$t6,lista	# $t6 = lista
do:				# do {
	li	$t4,FALSE	#   houveTroca = FALSE;
	li	$t5,0		#   i = 0;
for:				
	bgtu	$t5,SIZE,endfor	#   while( i < SIZE-1 ) {
if:
	sll	$t7,$t5,2	#     $t7 = i*4
	addu	$t7,$t7,$t6	#     $t7 = &lista[i]
	lw	$t8,0($t7)	#     $t8 = lista[i]
	lw	$t9,4($t7)	#     $t9 = lista[i+1]
	bgeu	$t8,$t9,endif	#     if( lista[i] > lista[i+1] ) {
	sw	$t8,4($t7)	#       lista[i+1] = $t8
	sw	$t9,0($t7)	#       lista[i] = $t9
	li	$t4,TRUE	#       houve_troca = TRUE;
endif:				#     }
	addi	$t5,$t5,1	#   i++;
	j	for
endfor:				#   }
	bne	$t4,TRUE,endw	# } while( houve_troca == TRUE );
	j	do
endw:
	la	$a0,str2
	li	$v0,print_string
	syscall			# print_string(str2);
	li	$t5,0		# i = 0;
	la	$t6,lista	# $t6 = lista
pfor:
	bgeu	$t5,SIZE,epfor	# while( i < SIZE ) {
	sll	$t7,$t5,2	#   $t7 = i*4
	addu	$t7,$t7,$t6	#   $t7 = &lista[i]
	lw	$a0,0($t7)	#   $a0 = lista[i]
	li	$v0,print_int10
	syscall			#   print_int10(lista[i]);
	la	$a0,str3
	li	$v0,print_string
	syscall			#   print_string(str3);
	addi	$t5,$t5,1	#   i++;
	j	pfor
epfor:				# }
	jr	$ra		#terminar programa





















