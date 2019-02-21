#include <stdio.h>
 
//sub-function
void f1(void);

//define global static variable
static int m1=10;       

//main function
int main()
{
 
  printf ("m1=%d\n",m1);

  while (m1--)
  {
      f1();
  }
  return 0;
}

//sub-function 
void f1(void)
{
                
  static int sm1=5;
  printf("sm1=%d\n",sm1);

  sm1++;
  
  printf("m1=%d\t sm1=%d \n",m1,sm1);
}
