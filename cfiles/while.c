#include<stdio.h>
#include<ctype.h>

void c1()
{
	//0 is flase !0 is ture
	printf("%d\n", isupper('a'));
	printf("%d\n", islower('a'));
	
	//ascii 97 is an alpha
	printf("%d\n", 'a');
	
	//print ascii
	printf("%c\n", 53);
	printf("%d\n", isalpha(97));
	printf("%d\n", isdigit(9));
	
	//0~127
	for (int i = 0; i < 127; i++)
		printf("%c ", i);

	printf("\nCaptial letter:%c\n", toupper('a'));

	int var, var_index = 0;
	int var_digit[6];
	char unit[10] = { 'a','b','c','d','e','f','g','h','i','j' };
	var = 2018;
	int m=0;

	while (var != 0)
	{
		var_digit[m] = var % 10;
		var = var / 10;
		var_index++;
		m++;
	}

	printf("total digits are %d\n", m );
	for (int n = 0; n < m; n++)
		printf("\#%d is %c\n", n+1, unit[var_digit[n]]);

}

void c2()
{


}
