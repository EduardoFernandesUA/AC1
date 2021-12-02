# Mapa de Registos
#   n_even: $t0
#   n_odd: $t1
#   p1: $t2
#   p2: $t3
#   (a + N) e (b + n_odd): $t4
#   *p1: $t5
#   *p2: $t6
#   *p1rem: $t7
	.data
	.eqv	print_int10,1
	.eqv	read_int,5
	.eqv	N,5
a:	.space	20
c:	.space	20
	.text
	.globl main
main:
	li	$t0,0
	li	$t1,0
	la	$t2,a
	li	$t4,N
	sll	$t4,$t4,2
	addu	$t4,$t4,$t2
for1:	bge	$t2,$t4,efor1
	li	$v0,read_int
	syscall
	sw	$v0,0($t2)
	addiu	$t2,$t2,4
	j	for1
efor1:	
	la	$t2,a
	la	$t3,c
for2:	bge	$t2,$t4,efor2
	lw	$t5,0($t2)
	rem	$t7,$t5,2
if:	beqz	$t7,else
	sw	$t5,0($t3)
	addiu	$t3,$t3,4
	addi	$t1,$t1,1
	j	endif
else:	
	addi	$t0,$t0,1
endif:
	addiu	$t2,$t2,4
	j	for2
efor2:
	la	$t3,c
	sll	$t4,$t1,2
	addu	$t4,$t4,$t3
for3:	bge	$t3,$t4,efor3
	lw	$a0,0($t3)
	li	$v0,print_int10
	syscall
	addiu	$t3,$t3,4
	j	for3
efor3:
	jr	$ra








