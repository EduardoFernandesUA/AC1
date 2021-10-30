# Mapa de registos
#  $t0 - value
#  $t1 - bit
#  $t2 - i
#  $t3 - value of remaining
	.data
		str1: .asciiz "Introduza um numero: "
		str2: .asciiz "\nO valor em binario 'e: "
		.eqv	print_string,4
		.eqv	read_int,5
		.eqv	print_char,11
		.text
		.globl main

main:
	la		$a0,str1
	li		$v0,print_string
	syscall							# print_string(str1);
	
	li		$v0,read_int
	syscall
	or		$t0,$0,$v0
	
	li		$t2,0
for:
	rem		$t3,$t2,4
	bne		$t3,$0,endremif
	li		$a0,' '
	li		$v0,print_char
	syscall							# print_char(' ');
endremif:
	bgeu	$t2,32,endfor
	andi	$t1,$t0,0x80000000
	
	beq 	$t1,$0,else
	li		$a0,'1'
	li		$v0,print_char
	syscall							# print_char('1');
	j		endif
else:
	li		$a0,'0'
	li		$v0,print_char
	syscall							# print_char('0');
endif:
	sll		$t0,$t0,1
	addi	$t2,$t2,1
	j 		for
endfor:
	jr		$ra














	