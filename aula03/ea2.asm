# Mapa de registos:
#  t0 - gray
#  t1 - bin
#  t2 - mask

	.data
		str1: .asciiz "Introduza um numero: "
		str2: .asciiz "\nValor em código Gray: "
		str3: .asciiz "\nValor em binario: "
		.eqv  	print_string,4		# input: $a0
		.eqv	read_int,5			# output: $v0
		.eqv	print_int16,34		# input: $a0 (unsigned int)
	.text
	.globl main
	
	