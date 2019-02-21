#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<time.h>

int main(void)
{
	int ttt= time(NULL);
	//int ttt = timer_gettime(NULL);
	printf("%d\n", ttt);

		srand(ttt);
		for(int i = 0; i < 10; i++)
		{
			printf("the xxxx is %f\n", (rand()%100)/100.0);
			printf("the xxxx is %f\n", (float)rand()/RAND_MAX);
		}

	return 0;
}



/*
int main(void)
{
	const char *ttt = "2015-12-13";
	int year, month, day;
	int n = sscanf_s(ttt, "%d-%d-%d", &year, &month, &day);
	if (n != 3)
	{
		printf("bad formaty !\n");
	}
	return 0;
}

*/

/*
int main()
{
char *buf=(char*)malloc(128);
sprintf_s(buf,128, "Name:%s\tage: %d\n", "yang",33); // no show in screen
//printf("%s", buf);
return 0;
}
*/


/*
int main()
{
	int a = 123;
	printf("a=%d\n", a);

	int *b = &a;
	printf("b=%d\n", *b);

	*b = 999;
	printf("new a=%d\n", a);
	return  0;

}
*/

/*
int main()
{
	int a = 1;
	printf("%p\n", &a);
	int &r = a;
	r = 999;
	printf("%p\n", &r);
	printf("%d\n", r);
	printf("%d\n", a);
	return 0;
}
*/

/*
int number = 0;


int &test()
{
	int&cc = number;
	return cc;
}
*/
//simplify int test()

/*
int &test()
{
return number;
}

int main()
{

test()=123; //assign in the left
printf("%d\n", number);

char line[21];//room for 20 chars + '\0'
gets_s(line,20);
printf("%s\n", line);



return 0;
}
*/




/*
struct xxxx
{
	int id;
	char name[16];
};

int main()
{
	xxxx a = {1,"yang"};
	xxxx &r = a;
	int size = sizeof(r);
	r.id = 999;
	strcpy_s(r.name, "yang");
	
	return 0;
}
*/

