/*
 *Author:@ yangspot.com
 */

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int main() 
{
	errno_s xxx; //rename of int
	FILE *fff;
	
	// fopen_s(char const*, _FileName, char const* _Mode);
	xxx = fopen_s(&fff, "aaa.txt", "w"); 
	
	if (xxx == 0)
		printf("open success!\n");
	else
		printf("open failed !\n");

	char bb[] = "hi this is form yang";

	//write into file fff
	fwrite(bb, sizeof(char), strlen(bb), fff); 

	int cc[4] = { 0xa1456,0xc123,0xd555,0xd234 };
	
	//multi write  
	for (int i = 0; i < 4; i++) {
		//buffer
		char text[16] ;
		
		//sprintf_s int hexdecimal->char decimal
		sprintf_s(text, 16, "%d,", cc[i]);

		fwrite(text, sizeof(char), strlen(text), fff);
	}
	xxx = fclose(fff);

	system("pause");
	return 0;
}
