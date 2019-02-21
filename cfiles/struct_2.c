#include<stdio.h>
#include<stdlib.h>
#include<string.h>


struct car {
	char m[32];
	double  p;
};
struct user {
	char n[16];
	double  d;
	struct car *a;
};

void buy(struct user *buff)
{
	struct car *xx; 
	xx = (struct car *)malloc(sizeof(struct car));
	//xx = (struct car *)malloc(sizeof(1024*1));
	strcpy_s(xx->m, 32, "lamborghni");
	xx->p = 999;

	buff->a = xx;
	buff->d -= xx->p;	
	//free(xx);
}

void discard(struct user *buff)
{
	free(buff->a);
	buff->a = NULL;
}

void sell(struct user *buff1, struct user *buff2)
{
	
	buff2->d -= (buff1->a)->p;
	buff1->d += (buff1->a)->p;
	
	buff2->a = buff1->a; // no need for initiallisation 
	buff1->a = NULL;     // address is the same 

	//buff2->a = (struct car *)malloc(sizeof(struct car));// initiallise buff2->a! the address is not the saem!
	//memcpy((buff2->a)->m, (buff1->a)->m, 32);
	//(buff2->a)->p = (buff1->a)->p;
	//buff1->a = NULL;


}


int main()
{
	struct user yang;
	strcpy_s(yang.n, 16, "yang");
	yang.d = 3000;
	yang.a = NULL;

	struct user yangxxx;
	strcpy_s(yangxxx.n, 16, "yangxxx");
	yangxxx.d = 3000;
	yangxxx.a = NULL;


	buy(&yang);
	//discard(&yang); 
	sell(&yang, &yangxxx);
	printf("-----------------------\n");
	//return 0;

	/*
	int size = 4 * sizeof(struct a);
	struct a *p;
	p = (struct a *)malloc(size);
	p[0].b = 123;
	strcpy_s(p[0].c, 15, "yang");
	p[1].b = 321;
	strcpy_s(p[1].c, 15, "gnay");

	printf("%d %s\n", p[0].b, p[0].c);
	printf("%d %s\n", (p+1)->b, (p+1)->c);
	printf("%d\n", size);

	free(p);
	return 0;
	*/


	/*
			char *p = (char*)malloc(4*1024*1024);
		for (int i = 0; i < 1024; i++)
		{
			printf("%p", p + i);
             //p[i] = i + 1;
		}

	free(p);
	return 0;
	*/

	
}
