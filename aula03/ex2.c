#include <stdio.h>

int main(void)
{
	unsigned int value, bit, i;

	printf("Introduza um numero: ");
	scanf("%u", &value);
	printf("\nO valor em binário e': ");
	for (i=0; i<32 ;i++) {
		if ( (i%4)==0 )
			printf(" ");
		bit = (value & 0x80000000) >> 31; // isola bit 31
		// if ( bit != 0 )
		// 	printf("1");
		// else
		// 	printf("0");
		printf("%c",0x30 + bit);
		value = value << 1;
	}
	printf("\n\n");
	return 0;
}
