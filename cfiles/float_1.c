/*
 *Author:@ yangspot.com
 */
  
#include <stdio.h>
#include <float.h>
//#include <limits.h>
 
void main() {
  // printf("int size : %lu \n", sizeof(int));
   printf("float max size : %lu \n", sizeof(float));
   printf("float min value: %E\n", FLT_MIN );
   printf("float max value: %E\n", FLT_MAX );
   printf("precision: %d\n", FLT_DIG );
  
}
