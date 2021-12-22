	.data
str1:	.asciiz	"2020 e 2024 sao anos bissextos"
str2:	.asciiz	"101101"
	.text
	.globl main
main:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	la	$a0,str2 # str1 to Part 1, str2 to Part 2, also make the changes indide atoi function
	li	$v0,1
	jal	atoi
	move	$a0,$v0
	li	$v0,1
	syscall
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra






# Mapa de registos
# $v0: res
# $a0: s
# $t0: *s
# $t1: digit
# Sub-rotina terminal: não devem ser usados registos $sx
atoi:	li	$v0,0		# res = 0;
atoi_w:	lb	$t0,0($a0)	# while(*s >= '0'  && *s <= '1') # change '1' to '9' to run Part 1
	blt	$t0,'0',atoi_ew	#
	bgt	$t0,'1',atoi_ew	# { # change '1' to '9' to run Part 1
	sub	$t1,$t0,'0'	#   digit = *s - '0'
	addiu	$a0,$a0,1	#   s++;
	
	# Part 1
	# mul	$v0,$v0,10	#   res = 10 * res;
	# add	$v0,$v0,$t1	#   res = 10 * res + digit;
	
	# Part 2
	sll	$v0,$v0,1	#   res << 1;
	add	$v0,$v0,$t1	#   res = res + digit;
	
	j	atoi_w		# }
atoi_ew:jr	$ra		# termina sub-rotina