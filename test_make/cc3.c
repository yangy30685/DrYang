#include"cc1.h"

void f1()
{
	int num = 1;

	int *pt_num = &num;

	int *pt_num2 = pt_num;
	
	//%p print pointer address
	printf("address:%p\tthe value is:%p\n", pt_num,&num);
	
	//a different pointer address
	printf("pointer's pointer %p\n", pt_num2);
	
	*pt_num = 0;//change the value of the pointer

	printf("the pointer valuse is:%d\n", *pt_num);

}

void f2()
{
	int n1 = 1;
	int n2 = 2;
	int *pt1 = &n1;
	int *pt2 = &n2;
	
	printf("n1 is:%d\t address is:%p\n", n1, pt1);
	
	printf("n2 is:%d\t address is:%p\n", n2, pt2);
	
	//n1 = n2;//change the value not the address
	
	pt2 = pt1;
	
	printf("n1 is:%d\t address is:%p\n", n1, pt1);
	
	printf("n2 is:%d\t address is:%p\n", *pt2, pt2);

}

void f3()
{
	double s[] = { 1.0,2,3,4,5 };
	printf("array address:%p\n1st element:%p\n", s, &s[0]);
	double *pt3 = s;
	for (int i = 0; i < sizeof(s) / sizeof(s[0]); ++i)
		printf("%.3lf\n", *pt3++);   // *pt3++ or *++pt3 think! 8<++
	    //printf("%.3lf\n", pt3[i]); // pointer equivalent to array
		//printf("%.3lf\n", *(pt3+i));
	pt3 = s;//reset the pointer
	for (int i = 0; i < sizeof(s) / sizeof(s[0]); ++i)
		printf("%.3lf\n", *(pt3++));
}

void f4()
{	
	double s[] = { 1.0,2,3,4,5,8};
	double *pt3 = s;
	double t;
	int size = sizeof(s) / sizeof(s[0]);

	for (int i = 0; i < size/2; ++i)
	{
	
		t = s[i];
		s[i] = s[size-i-1];
		s[size-i-1] = t;
	}
	
	for (int i = 0; i < size; ++i)
		printf("%.3lf\n", *(pt3+i));
	
	double *pstart = s;  
	double *pend = s + size - 1;
	double m;

	if(size%2==0)
		while ((pstart+1) != pend)// 
		{
			m = *pstart;
			*pstart = *pend;
			*pend = m;

			pstart++;
			pend--;
		}
	else
		while (pstart != pend)//
		{
			m = *pstart;
			*pstart = *pend;
			*pend = m;

			pstart++;
			pend--;
		}
	

	for (int i = 0; i < size; ++i)
		printf("%.3lf\n", *(pt3 + i));
}

void f5()
{
	double ss[2][3] = {
		{2,1,1},
		{4,5,6},
	};
	double(*pt_ss)[3] = ss; //2d dimensional pointer

	for (int j = 0; j < 2; j++)
	{
		for (int i = 0; i < 3; ++i)
			//printf("%d%d is %.3lf\t", j + 1, i + 1, ss[j][i]);
			printf("%d%d is %.3lf\t", j + 1, i + 1, *(*(pt_ss+j)+i));
	printf("\n");
	}
}

