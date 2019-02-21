#include<stdio.h>
#include<ctype.h>
#include<stdlib.h>


int main()
{	
	extern void c1();

	extern void c2();
	
	c1();
	c2();
	

	system("pause");
	return 0;
}
