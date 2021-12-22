	.data
		str1: .asciiz "Uma string qualquer"
		str2: .asciiz "AC1 - P"
		str3: .asciiz "Introduza 2 numeros\n"
		str4: .asciiz "A soma dos dois numeros e': "
		.eqv	print_string,4
		.eqv    read_int,5
		.eqv	print_int,1
	.text
	.globl	main
main: 
	la   $a0,str3
	ori  $v0,$0,print_string
	syscall
	
	ori  $v0,$0,read_int
	syscall
	or   $t0,$v0,$0
	
	ori  $v0,$0,read_int
	syscall
	or   $t1,$v0,$0
	
	add  $t2,$t0,$t1
	
	la   $a0,str4
	ori  $v0,$0,print_string
	syscall
	
	or   $a0,$0,$t2
	ori  $v0,$0,print_int
	syscall
	
	jr   $ra
	