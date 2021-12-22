# Mapa de Registos
#  t0 - i
#  t1 - j
#  t2 - 
#  t3 - &lista[0]
#  t4 - &lista[i]
#  t5 - &lista[j]
#  t6 - lista[i]
#  t7 - lista[j]

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
	li	$t0,0		# i = 0;
	la	$t3,lista	# $t3 = lista;
readw:	bge	$t0,SIZE,ereadw	# while( i<SIZE ){
	la	$a0,str1
	li	$v0,print_string
	syscall			#   pritn_string(str1);
	sll	$t4,$t0,2	#   $t4 = i * 4
	addu	$t4,$t4,$t3	#   $t4 = &lista[i]
	li	$v0,read_int
	syscall
	sw	$v0,0($t4)	#   lista[i] = read_int()
	addi	$t0,$t0,1	#   i++;
	j	readw		# }
ereadw:
	li	$t0,0		# i = 0;
fori:	bgt	$t0,SIZE,efori	# while( i<SIZE-1 ){
	move	$t1,$t0
	addi	$t1,$t1,1	#   j = 0;
forj:	bge	$t1,SIZE,eforj	#   while( j<SIZE ){
	sll	$t4,$t0,2	#     $t4 = i * 4
	addu	$t4,$t4,$t3	#     $t4 = &lista[i]
	lw	$t6,0($t4)	#     $t6 = lista[i]
	sll	$t5,$t1,2	#     $t5 = j * 4
	addu	$t5,$t5,$t3	#     $t5 = &lista[j]
	lw	$t7,0($t5)	#     $t7 = lista[j]
if:	ble	$t6,$t7,endif	#     if( lista[i] > lista[j] ){
	sw	$t6,0($t5)	#       lista[i] = $t7
	sw	$t7,0($t4)	#       lista[j] = $t6
endif:				#     }
	addi	$t1,$t1,1	#     j++;
	j	forj
eforj:				#   }
	addi	$t0,$t0,1	#   i++;
	j	fori
efori:				# }
	la	$a0,str2
	li	$v0,print_string
	syscall			# print_string(str2);
	li	$t0,0		# i = 0;
printw:	bge	$t0,SIZE,eprintw# while( i<SIZE ){
	sll	$t4,$t0,2	#   $t4 = i * 4
	addu	$t4,$t4,$t3	#   $t4 = &lista[i]
	lw	$a0,0($t4)	#   $a0 = lista[i]
	li	$v0,print_int10
	syscall			#   print_int10(lista[i]);
	la	$a0,str3
	li	$v0,print_string
	syscall
	addi	$t0,$t0,1	#   i++;
	j	printw		# }
eprintw:
	jr	$ra
	