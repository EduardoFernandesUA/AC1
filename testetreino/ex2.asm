# Mapa de Registos
#	t0 - i
#	t1 - v
#	t2 - &(val[0]) - addrs

	.data
		.eqv	SIZE,8
		.eqv	print_int10,1
		.eqv	print_char,11
		.eqv	print_string,4
		val:  .word 8,4,15,-1987,327,-9,27,16
		str1: .asciiz "Result is: "
	.text
	.globl main
	
main:
	li		$t0,0					# i = 0;
	la		$t2,val					# addrs = val
	
do:									# do {	
	add		$a0,$t2,$t0
	lw		$t1,0($a0)				#	v = val[i];
	
	li		$a1,SIZE				#   
	addi	$a1,$a0,16				#   $a1 = &val+i + SIZE/2  (SIZE/2 == (8/2=4)*4=16)
	lw		$a2,0($a1)				#   $a2 = *$a1
	
	sw		$a2,0($a0)				#	val[i] = val[i+SIZE/2];
	sw		$t1,0($a1)				#   val[i+SIZE/2] = v;
	
	addi	$t0,$t0,4				# 	i++;
	
	bge		$t0,16,enddowhile		# } while( i < SIZE/2);
	j		do
enddowhile:	
	
	la		$a0,str1
	li		$v0,print_string
	syscall							# print_string(str1);
	
	li		$t0,0					# i = 0;

doprint:							# do {
	add		$a0,$t2,$t0
	lw		$a0,0($a0)
	li		$v0,print_int10
	syscall							# print_int10(val[i]);
	
	addi	$t0,$t0,4				# i++;
	
	li		$a0,','
	li		$v0,print_char			# print_char(',');
	syscall
	
	li		$a0,SIZE
	mul		$a0,$a0,4
	blt		$t0,$a0,doprint			# } while( i < SIZE);
			
	jr $ra
