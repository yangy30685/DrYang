#include<stdio.h>
 
int main()
{	
int n;
 
printf("insert 1 or 2 or other: ");

scanf("%d",&n);
	
	switch(n)
		{
    	case 1:printf("Monday \n");
	break;//break to quit loop
	case 2:printf("Tuesday\n");
	break;
        default:printf("error\n");
  		}
return 0;

}

