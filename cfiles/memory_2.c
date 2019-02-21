#include<stdio.h>
#include<string.h>

struct student {
	int  id;
	char name[16];
	int scores[3];
} data[100];    //define

int count = 0;

int fun1(struct student *s) {
	printf("input id:\n");
	scanf("%d", &s->id);
	printf("input name:\n");

	//strcpy(s.name,"")
	scanf("%s", s->name,16);
	printf("input 3 scores:\n ");
	scanf("%d%d%d", &s->scores[0], &s->scores[1], &s->scores[2]);
	return 0;
}


int fun2(const struct student c) {
    //memcpy(&b,&a,sizeof(a)) 
	memcpy(&data[count], &c, sizeof(c)); 
	
	//data[count] = c; ////////wrong!!!
	count++;
	return 0;
}


void fun3(void)

{
	printf("ID NAME SCORE\n");
	printf("------------------------------------------\n");
	for (int i = 0; i<count; i++)
	{
		struct student *s = &data[i];
		printf("%d\t%s\t%d,%d,%d\n",
			s->id,
			s->name,
			s->scores[0],
			s->scores[1],
			s->scores[2]);
	}

	printf("------------------------------------------\n");
}

int on_add()
{
	struct student a;
	fun1(&a);
	fun2(a);
	return 0;
}

struct student* zhao(const char* name)
{
	for (int i = 0; i<count; i++)
	{
		struct student *b = &data[i];
		if (strcmp(name, b->name) == 0)
			return b;
	}
	return NULL;
}


int main()
{

	char cmdline[128];
	while (1)//loop  
	{
		printf("> ");
		scanf("%s", cmdline,128);//input command
							  //printf("cmd: %s \n",cmdline);
							 // exit function 
		if (strcmp(cmdline, "exit") == 0)
		{
			printf("bye\n");
			break;
		}
		// list func;
		if (strcmp(cmdline, "list") == 0)
		{
			fun3();
			continue;
		}
		if (strcmp(cmdline, "count") == 0)
		{
			printf("total :%d\n", count);
			continue;
		}
		if (strcmp(cmdline, "zhao") == 0)
		{
			printf("enter a name\n");
			char n[16];
			scanf("%s", n,16);
			struct student *buff = zhao(n);
			if (buff)
			{
				printf("id:%d, name:%s,score: %d %d %d\n",
					buff->id, buff->name,
					buff->scores[0],
					buff->scores[1],
					buff->scores[2]
				);
			}
			continue;
		}
		if (strcmp(cmdline, "add") == 0)
		{
			on_add();
			continue;
		}

		printf("bad input try again.. \n");
	}

	return 0;
}
