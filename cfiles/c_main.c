/*
 *Author:@ yangspot.com
 */

#include <stdio.h>

//define a variable
int count;

//declear extern function 
extern void fun1();
 
int main() 
{
   count = 5;
// use extern function
   fun1();
}
