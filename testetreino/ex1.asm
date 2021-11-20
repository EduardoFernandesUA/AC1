# Mapa de Registos
#	$t0 - val
#	$t1 - n
#	$t2 - min
#	$t3	- max

	.data
		str1: .asciiz "Digite ate 20 inteiros (zero para terminar):"
		str2: .asciiz "Máximo/minimo são: "
		.eqv	print_string,4
		.eqv	print_int10,1
		.eqv	read_int,5
		.eqv	print_char,11
	.text
	.globl main
	
main:
	li		$t1,0				# n = 0;
	li		$t2,0x7FFFFFFF		# min = 0x7FFFFFFF;
	li		$t3,0x80000000		# max = 0x80000000;
	
	la		$a0,str1
	li		$v0,print_string
	syscall						# print_string(str1);

do:								# do {
	li		$v0,read_int
	syscall
	move	$t0,$v0				# 	val = read_int();
	
	beqz	$t0,endif			# 	if( val!=0 ) {
	
	ble		$t0,$t3,endmidif	#		if( val > max )
	move	$t3,$t0				#			max = val;
endmidif:
	bge		$t0,$t2,endif		#		if( val < min )
	move	$t2,$t0				#			min = val;

endif:							#	}
	addi	$t1,$t1,1			#	n++;
	
	bgeu	$t1,20,endwhile		# } while( n < 20   ||
	beqz 	$t0,endwhile		#		   val != 0 );
	j		do
	
endwhile:

	la		$a0,str2
	li		$v0,print_string
	syscall							# print_string(str2);
	
	move	$a0,$t3
	li		$v0,print_int10
	syscall							# print_int(max);
	
	li		$a0,':'
	li		$v0,print_char
	syscall							# print_char(":");
	
	move	$a0,$t2
	li		$v0,print_int10
	syscall							# print_int(min);
	
	jr		$ra
	












