#include <stdio.h>

#define SIZE 10

void main(void)
{
	static int lista[SIZE];
	int aux, *i, *j;

	for(i = lista; i<lista+SIZE; i++)
	{
		printf("\nIntroduza numero: ");
		scanf("%d", i);
	}

	for(i = lista; i<lista+SIZE-1; i++)
	{
		for(j = i+1; j < lista+SIZE; j++)
		{
			if( *i > *j )
			{
				aux = *i;
				*i = *j;
				*j = aux;
			}
		}
	}

	printf("\nConteudo do array: \n");
	for(i = lista; i<lista+SIZE; i++)
	{
		printf("%p %d\n",i,*i);
	}
}