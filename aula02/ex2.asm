# Mapa de registos:
#  $t0 - number
#  $t1 - gray
#  $t2 - number shifted left logical
#  $t3 - number shifted right logical
#  $t4 - number shifted right aritmetric
#  $t5 - num
#  $t6 - bin
#  $t7 - num helper

	.data
	.text
	.globl	main
main:	li $t0,4
	
	sll $t2,$t0,1	# b)
	srl $t3,$t0,1	# ...
	sra $t4,$t0,1	# ...
	
	xor $t1,$t0,$t3 # gray = bin ^ (bin >> 1)
	
	or	$t5,$0,$t1
	srl $t7,$t5,4
	xor $t5,$t5,$t7
	srl $t7,$t5,2
	xor $t5,$t5,$t7
	srl $t7,$t5,1
	xor $t5,$t5,$t7
	or $t6,$0,$t5
	
	
	jr  $ra
