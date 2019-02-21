/*
 *Author:@ yangspot.com
 */

#include <stdio.h>
 
int main () {
    //define a 10 array
   int n[ 10 ];
   int i,j;
 
   /* initial array */         
   for ( i = 0; i < 10; i++ ) {
      n[ i ] = i + 100; 
   }
   
   /* print out */
   for (j = 0; j < 10; j++ ) {
      printf("Element[%d] = %d\n", j, n[j] );
   }
 
   return 0;
}
