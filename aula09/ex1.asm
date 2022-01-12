
	.data
	.eqv	read_int,5
	.eqv	print_float,2
k1:	.float	2.59375
	.text
	.globl main
main:
do:
	li	$v0,read_int
	syscall
	mtc1	$v0,$f0
	cvt.s.w	$f0,$f0
	l.s	$f2,k1
	mul.s	$f0,$f0,$f2
	mov.s	$f12,$f0
	li	$v0,print_float
	syscall
	mtc1	$0,$f2
	c.eq.s	$f0,$f2
while:	bc1f	do
	
	li	$v0,0
	jr	$ra
