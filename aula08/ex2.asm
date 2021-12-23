#Mapa de Registos
# str:	$s0
# val:	$s1
# O main é, neste caso, uma sub-rotina intermédia
	.data
str:	.space	34
	.eqv	STR_MAX_SIZE,33
	.eqv	read_int,5
	.eqv	print_string,4
	.text
	.globl main
main:	addiu	$sp,$sp,-12	# reserva espaço na stack
	sw	$s0,0($sp)	# guarda registos $sx na stack
	sw	$s1,4($sp)	#
	sw	$ra,8($sp)	# guarda $ra na stack
do:				# do {
	li	$v0,read_int
	syscall
	move	$s1,$v0		#   val = read_int()
	
	move	$a0,$s1
	li	$a1,2
	la	$s2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall			# print_string( itoa(val, 2, str) );
	
	move	$a0,$s1
	li	$a1,8
	la	$s2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall			# print_string( itoa(val, 8, str) );
	
	move	$a0,$s1
	li	$a1,16
	la	$s2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall			# print_string( itoa(val, 16, str) );

	bnez	$s1,do		# } while( val != 0 )

	li	$v0,0

	lw	$s0,0($sp)	# repõe registos $sx na stack
	lw	$s1,4($sp)	#
	lw	$ra,8($sp)	# repõe $ra na stack
	addiu	$sp,$sp,12	# liberta espaço na stack
	jr	$ra		# termina programa




# Mapa de registos
# n:	  $a0 -> $s0
# b:	  $a1 -> $s1
# s:	  $a2 -> $s2
# p:	  $s3
# digit:  $t0
# Sub-rotina intermédia
itoa:	addiu	$sp,$sp,-20	# reserva espaço na stack
	sw	$s0,0($sp)	# guarda registos $sx e $ra
	sw	$s1,4($sp)
	sw	$s2,8($sp)
	sw	$s3,12($sp)
	sw	$ra,16($sp)
	
	move	$s0,$a0		# copia n, b e s para registos
	move	$s1,$a1		# "callee-saved"
	move	$s2,$a2
	move	$s3,$a2		# p = s;
	
itoa_do:			# do {
	remu	$t0,$s0,$a1	#   digit = n % b;
	divu	$s0,$s0,$s1	#   n = n / b;
	move	$a0,$t0
	jal	toascii
	sb	$v0,0($s3)	#   *p = toascii( digit );
	addiu	$s3,$s3,1	#   p++;
	bgtz	$s0,itoa_do	# } while( n > 0 );
	sb	$0,0($s3)	# *p = 0;
	move	$a0,$s2
	jal	strrev		# strrev(s);
	move	$v0,$s2		# return s;
	
	lw	$s0,0($sp)	# guarda registos $sx e $ra
	lw	$s1,4($sp)
	lw	$s2,8($sp)
	lw	$s3,12($sp)
	lw	$ra,16($sp)
	addiu	$sp,$sp,20	# liberta espaço na stack
	jr	$ra
	
	
	
# Mapa de Registos
# $a0: v
toascii:
	addiu	$a1,$a1,'0'		# v += '0';
	bleu	$a1,'9',toascii_eif	# if( v > '9' )
	addiu	$a1,$a1,7		#   v += 7; // 'A' - '9' - 1
toascii_eif:
	move	$v0,$a1
	jr	$ra



# char *strrev(char *str);
# Mapa de Registos
#  a0: str (argumento é passado em $a0)
#  s1: p1 (registo callee-saved)
#  s2: p2 (registo callee-saved)
#
strrev:	addiu	$sp,$sp,-16		# reserva espaço na stack
	sw	$ra,0($sp)		# guarda endereço de retorno
	sw	$s0,4($sp)		# guarda valor dos registos
	sw	$s1,8($sp)		#   s0, s1 e s2
	sw	$s2,12($sp)		#
	move	$s0,$a0			# registo "callee-saved"
	move	$s1,$a0			# p1 = str
	move	$s2,$a0			# p2 = str
strrev_while1:	
	lb	$a0,0($s2)
	beq	$a0,'\0',strrev_ew1	# while( *p2 != '\0' ) {
	addiu	$s2,$s2,1		#   p2++;
	j	strrev_while1		# }
strrev_ew1:				# 
	addiu	$s2,$s2,-1		# p2--;
strrev_while2:				# while(p1 < p2) {
	bge	$s1,$s2,strrev_ew2	#
	move	$a0,$s1
	move	$a1,$s2
	jal 	exchange		#   exchange(p1,p2);
	addiu	$s1,$s1,1		#   p1++;
	addiu	$s2,$s2,-1		#   p2--;
	j	strrev_while2		# }
strrev_ew2:
	move	$v0,$s0			# return str
	lw	$ra,0($sp)		# repoe endereço de retorno
	lw	$s0,4($sp)		# repoe valor dos registos
	lw	$s1,8($sp)		#   s0, s1 e s2
	lw	$s2,12($sp)		#
	addiu	$sp,$sp,16		# liberta espaço na stack
	jr	$ra


# void exchange(char *c1, char *c2);	
# Mapa de Registo
#  a0: *c1
#  a1: *c2
#  s0: c1
#  s1: c2
exchange:
	addiu	$sp,$sp,-12
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	sw	$s1,8($sp)
	
	lb	$s0,0($a0)
	lb	$s1,0($a1)
	sb	$s0,0($a1)
	sb	$s1,0($a0)
	
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	addiu	$sp,$sp,12
	jr	$ra





















