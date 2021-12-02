# Mapa de Registos
#  val: t0
#  n:   t1
#  min: t2
#  max: t3
	.data
	.eqv	print_int10,1
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_char,11
str1:	.asciiz	"Digite ate 20 inteiros (zero para terminar):"
str2:	.asciiz	"Máximo/mínimo são: "
	.text
	.globl main
main:
	li	$t1,0		# n = 0;
	li	$t2,0x7FFFFFFF	# min = 0x7FFFFFFF;
	li	$t3,0x80000000	# max = 0x80000000;
	la	$a0,str1
	li	$v0,print_string
	syscall			# print_string(str1);
do:				# do{
	li	$v0,read_int
	syscall
	move	$t0,$v0		#   val = read_int();
if1:	beqz	$t0,eif1	#   if(val != 0) {
if2:	ble	$t0,$t3,if3	#     if(val > max)
	move	$t3,$t0		#       max = val;
if3:	bge	$t0,$t2,eif1	#     if(val < min)
	move	$t2,$t0		#       min = val;
eif1:				#   }
	addi	$t1,$t1,1	#   n++;
	bge	$t1,20,edo	# } while( n<20 &&
	beqz	$t0,edo		#          val!=0 );
	j	do
edo:	la	$a0,str2
	li	$v0,print_string
	syscall			# print_string(str2);
	move	$a0,$t3
	li	$v0,print_int10
	syscall			# print_int10(max);
	li	$a0,':'
	li	$v0,print_char
	syscall			# print_char(':');
	move	$a0,$t2
	li	$v0,print_int10
	syscall			# print_int10(min);
	jr	$ra
	
	
	
	