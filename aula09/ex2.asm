	.data
k1:	.double	5.0
k2:	.double 9.0
k3:	.double 32.0
ft:	.double 100.0
	.text
	.globl main
main:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)	# save $ra
	
	l.d	$f12,ft		# ft = ft = 100
	jal	f2c
	
	mov.d	$f12,$f0
	li	$v0,3
	syscall
	
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra







################################################
# ft: $f12
f2c:				# double f2c(double ft) {
				#   return (5.0 / 9.0 * (ft - 32.0));
				# }
	l.d	$f0,k1		# k1 = 5.0
	l.d	$f2,k2		# k2 = 9.0
	l.d	$f4,k3		# k3 = 32.0
	div.d	$f6,$f0,$f2	# temp1 = k1 / k2
	sub.d	$f8,$f12,$f4	# temp2 = ft - k3
	mul.d	$f0,$f6,$f8	# return temp1 * temp2;
	jr	$ra