#include <stdio.h>

#define SIZE 20

void main(void)
{
	static char str[SIZE + 1]; // Reserva espaço para um array de
	//"SIZE+1" bytes no segmento de
	// dados ("SIZE" carateres +
	// terminador)
	int num, i;

	//read_string(str, SIZE); // "str" é o endereço inicial do
	scanf("%s", &str);
	// espaço reservado para alojar a
	// string (na memória externa)
	num = 0;
	i = 0;
	while (str[i] != '\0') // Acede ao carater (byte) na
	// posição "i" do array e compara-o
	// com o carater terminador (i.e.
	// '\0' = 0x00)
	{
		if ((str[i] >= '0') && (str[i] <= '9'))
			num++;
		i++;
	}
	// print_int10(num);
	printf("%d", num);
}