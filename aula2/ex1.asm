	.data
	.text
	.globl	main
main:	ori $t0,$0,0x0F1E 	# valores de
	ori $t1,$0,0x000F 	#  entrada
	
	and $t2,$t0,$t1	 	# $t2 = $t0 & $t1
	or  $t3,$t0,$t1	 	# $t2 = $t0 | $t1
	nor $t4,$t0,$t1	 	# $t2 = $t0 nor $t1
	xor $t5,$t0,$t1	 	# $t2 = $t0 ^ $t1
	
	xori $t1,$t0,0xFFFFFFFF	# negação bit a bit
	
	jr $ra