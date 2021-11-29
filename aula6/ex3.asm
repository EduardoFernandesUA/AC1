# Mapa de registos
#  t0 - i
#  t1 - j
#  t2 - *i
#  t3 - *j
	
	.data
	.eqv	print_int10,1
	.eqv	print_string,4
	.eqv	print_char,11
	.eqv	SIZE,3
array:	.word	str1,str2,str3
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz	"ponteiros"
str4:	.asciiz	"\nString #"
str5:	.asciiz	": "
	.text
	.globl main
main:
	li	$t0,0		# i = 0;
for:	bge	$t0,SIZE,efor	# while( i<SIZE ){
	la	$a0,str4
	li	$v0,print_string
	syscall			#   print_string(str4);
	move	$a0,$t0
	li	$v0,print_int10
	syscall			#   print_int10(i);
	la	$a0,str5
	li	$v0,print_string
	syscall			#   print_string(str5);
	li	$t1,0		#   j = 0;
while:	sll	$t2,$t0,2
	la	$t3,array
	addu	$t2,$t2,$t3
	lw	$t2,0($t2)
	addu	$t2,$t2,$t1
	lb	$t2,0($t2)
	beq	$t2,'\0',ewhile	#   while( array[i][j] != '\0' ){
	move	$a0,$t2
	li	$v0,print_char
	syscall			#     print_char(array[i][j]);
	li	$a0,'-'
	li	$v0,print_char
	syscall			#     print_char('-');
	addi	$t1,$t1,1	#     j++;
	j	while		#   }
ewhile:
	addi	$t0,$t0,1	#   i++;
	j	for		# }
efor:
	jr	$ra