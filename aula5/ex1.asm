# Mapa de Resgistos
# 	t0 : i
#	t1 : lista
#	t2 : lista + i

	.data
		.eqv		SIZE,5
	str1:   .asciiz "\nIntroduza um numero: "
		.align 2
	lista:  .space 20
		.eqv	read_int,5
		.eqv	print_string,4
		.text
		.globl main

main:
	# i = 0;
	li		$t0,0

while:
	# if $t0 >= SIZE then endw
	bgeu	$t0,SIZE,endw

	# 	print_string("Introduza um numero: ")
	la		$a0,str1
	li		$v0,print_string
	syscall

	# 	$v0 = read_int
	li		$v0,read_int
	syscall

	# 	$t1 = lista (ou &lista[0])
	la		$t1,lista

	# 	$t2 = &lista[i]
	sll		$t2,$t0,2
	addu	$t2,$t2,$t1

	# 	lista[i] = read_int();
	sw		$v0,0($t2)

	# 	i++
	addi	$t0,$t0,1

	# }
	j			while	
endw:
	# termina programa
	jr		$ra
	
	
