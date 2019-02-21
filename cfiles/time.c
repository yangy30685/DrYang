#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include<time.h>
	
int print_date() {
	// time_t is a data type
    time_t demo_time;
	
    // get current time
    // demo_time = time(NULL);
    time(&demo_time);
	printf("%d\n", (int)demo_time);

    // use gmtime() -> struct tm类型
    /*
    struct tm {
        int tm_sec;  0-59
        int tm_min;  0-59
        int tm_hour; 0-23
        int tm_mday; 1-31
        int tm_mon;  0-11  1+p->tm_mon;
        int tm_year; 1900＋ p->tm_year;
        int tm_wday; 0-6
        int tm_yday; 0-365
        int tm_isdst; daylight savings time
    };
    */
    struct tm* time_obj;
    time_obj = gmtime(&demo_time);

    // sctime() -> Fri Jan 11 17:25:24 2008
   
    printf("%s", asctime(time_obj));
	return 0;
}	
	
int main() 
{
	
	print_date();

	for (int i=0;i<30;i++) {
		printf("*");
	}
	printf("\n");

	time_t time_obj_2;
	time_obj_2 = time(NULL);
	
	//use ctime();
	printf("%s", ctime(&time_obj_2));

	//use localtime
	struct tm* p = localtime(&time_obj_2);
	p = localtime(&time_obj_2); 

    printf("%d/%d/%d ", 1900 + p->tm_year, 1 + p->tm_mon, p -> tm_mday);

    printf("%d:%d:%d(Hour:Min:Sec)\n", p->tm_hour, p->tm_min, p->tm_sec);
	return 0;

}
