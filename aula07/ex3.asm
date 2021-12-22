# Mapa de Registos
#  s0: exit_value
#  s1: strlen(str1)

	.data
	.eqv	STR_MAX_SIZE,30
	.eqv	print_int10,1
	.eqv	print_string,4
str1:	.asciiz	"I serodatupmoC ed arutetiuqrA"
str2:	.space	31
str3:	.asciiz	"String too long: "
str4:	.asciiz	"\n"
	.text
	.globl main

main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
if:	la	$a0,str1
	jal	strlen
	move	$s1,$v0
	bgt	$s1,STR_MAX_SIZE,else
	la	$a0,str2
	la	$a1,str1
	jal	strcpy
	la	$a0,str2
	li	$v0,print_string
	syscall
	la	$a0,str4
	li	$v0,print_string
	syscall
	la	$a0,str2
	jal	strrev
	move	$a0,$v0
	li	$v0,print_string
	syscall
	li	$s0,1
	j	eif
else:
	la	$a0,str3
	li	$v0,print_string
	syscall
	move	$a0,$s1
	li	$v0,print_int10
	syscall
	li	$s0,-1
eif:
	move	$v0,$s0
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
	


#################################################
strlen:				# strlen(char *s) {
				#   $a0 -> char *s
				#   $v0 -> len
	li	$v0,0		#   len = 0;
strlen_w1:			#   while(*s++ != '\0') {
	lb	$t0, 0($a0)	#     $t0 = *s
	addiu	$a0,$a0,1	#     s++;
	beq	$t0,$0,strlen_ew1
	addi	$v0,$v0,1	#     len++;
	j	strlen_w1	#   }
strlen_ew1:
	jr	$ra		# }




#################################################
strcpy:				# char *strcpy(char *dst, char *src) {
	li	$t0,0
do:				# do {
	addu	$t1,$t0,$a1
	lb	$t2,0($t1)	#   temp = src[i]
	addu	$t1,$t0,$a0
	sb	$t2,0($t1)
	beq	$t2,'\0',edo
	addi	$t0,$t0,1
	j	do
edo:
	move	$v0,$a0
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
	


