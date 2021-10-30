	.data
		# empty
	.text
	.globl main

# $v0 é usado para execuçao de instrocoes

main:	ori $v0,$0,5	 	# define read_int() 
	syscall			# chamada ao syscall "read_int()"
	or  $t0,$0,$v0		# valor lido do teclado
	
	ori $t2,$0,8 	 # $t2 = 8
	add $t1,$t0,$t0  # $t1 = $t0 + $t0 = x + x = 2 * x
	add $t1,$t1,$t2  # $t1 = $t1 + $t2 = y = 2 * x + 8
	
	# print in base 10
	or  $a0,$0,$t1		# copy $t1 to print_int10() input ($a0)
	ori $v0,$0,1		# define print_int10()
	syscall			# chamada ao syscall "print_int10()"
	
	# print in base 16
	ori $v0,$0,34		# define print_int16()
	syscall			# chamada ao syscall "print_int16()"
	
	# print in base u10
	ori $v0,$0,36		# define print_intu10()
	syscall			# chamada ao syscall "print_intu10()"
	
	jr $ra		 # fim