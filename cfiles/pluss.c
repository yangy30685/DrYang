#include<stdio.h>

int main()

{

int i=5,j=5,p,q;

p=(i++)+(i++);
q=(++j)+(++j);
printf("%d,%d,%d,%d\n",p,q,i,j);

return 0;
}

