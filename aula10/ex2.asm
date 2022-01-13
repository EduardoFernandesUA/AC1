	.data
X1:	.double	1.0
X2:	.double	0.5
X3:	.double	0.0
X4:	.double	2.25
	.text
	.globl main
main:
	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$t0,X4
	l.d	$f12,0($t0)
	jal	sqrt
	
	mov.d	$f12,$f0
	li	$v0,3
	syscall

	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra
	







####################################################################
# val: $f12, aux: $f2, xn: $f4, i: $t0
sqrt:				# double sqrt(double val) {
	mov.d	$f10,$f12
	la	$t1,X1
	l.d	$f4,0($t1)
	li	$t0,0
	la	$t1,X3
	l.d	$f6,0($t1)
sqrt_if:
	c.le.d	$f10,$f6
	bc1t	sqrt_elif
	
sqrt_do:	
	mov.d	$f2,$f4		# aux = xn;
	div.d	$f6,$f10,$f4	# val/xn
	add.d	$f6,$f6,$f4	# xn + val/xn
	la	$t1,X2
	l.d	$f8,0($t1)
	mul.d	$f4,$f8,$f6	# xn = 0.5 * (xn + val/xn);
	c.eq.d	$f2,$f4
	bc1t	sqrt_edo
	addi	$t0,$t0,1
	bge	$t0,25,sqrt_edo
	j	sqrt_do
sqrt_edo:

	j	sqrt_eif
sqrt_elif:
	la	$t1,X3
	l.d	$f4,0($t1)
sqrt_eif:
	mov.d	$f0,$f4
	jr	$ra
	