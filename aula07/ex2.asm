# Mapa de Registos
	.data
str:	.asciiz	"ITED - orievA ed edadisrevinU"
	.text
	.globl main
	
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)	# prologo
	
	la	$a0,str
	jal	strrev		# temp = strrev(str);
	
	move	$a0,$v0
	li	$v0,4
	syscall			# print(temp);
	
	li	$v0,0		# return 0;
	
	lw	$ra,0($sp)	# epilogo
	addiu	$sp,$sp,4
	jr	$ra


# char *strrev(char *str);
# Mapa de Registos
#  a0: str (argumento é passado em $a0)
#  s1: p1 (registo callee-saved)
#  s2: p2 (registo callee-saved)
#
strrev:	addiu	$sp,$sp,-16	# reserva espaço na stack
	sw	$ra,0($sp)	# guarda endereço de retorno
	sw	$s0,4($sp)	# guarda valor dos registos
	sw	$s1,8($sp)	#   s0, s1 e s2
	sw	$s2,12($sp)	#
	move	$s0,$a0		# registo "callee-saved"
	move	$s1,$a0		# p1 = str
	move	$s2,$a0		# p2 = str
while1:	lb	$a0,0($s2)
	beq	$a0,'\0',ew1	# while( *p2 != '\0' ) {
	addiu	$s2,$s2,1	#   p2++;
	j	while1		# }
ew1:				# 
	addiu	$s2,$s2,-1	# p2--;
while2:				# while(p1 < p2) {
	bge	$s1,$s2,ew2	#
	move	$a0,$s1
	move	$a1,$s2
	jal 	exchange	#   exchange(p1,p2);
	addiu	$s1,$s1,1	#   p1++;
	addiu	$s2,$s2,-1	#   p2--;
	j	while2		# }
ew2:
	move	$v0,$s0		# return str
	lw	$ra,0($sp)	# repoe endereço de retorno
	lw	$s0,4($sp)	# repoe valor dos registos
	lw	$s1,8($sp)	#   s0, s1 e s2
	lw	$s2,12($sp)	#
	addiu	$sp,$sp,16	# liberta espaço na stack
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
	


























