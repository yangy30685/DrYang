#include<stdio.h>
#include<stdlib.h>

struct xxx {
	int id;
	char name[32];
	xxx *next;

};

struct xxx  data[4]=
{
	{1,"y1",0},
	{2,"y2",0},
	{3,"y3",0},
	{4,"y4",0}
};

xxx* find(xxx* ii, int dd)

{
	while (ii)
	{
		if (ii->id == dd)
		{
			
			printf("name is %s\n the search is over\n", ii->name);
			return ii;
		}
		ii = ii->next;
		
	}

	return NULL;
}

int main()
{
	data[0].next = &data[1];
	data[1].next = &data[2];
	data[2].next = &data[3];
	data[3].next = NULL;

	//xxx *buff = &data[0];
	  xxx *buff = data;// assign the address of the 1st element
	while (buff)
	{
		printf("id===%d\tname===%s\n", buff->id, buff->name);
		buff = buff->next;
	}

	find(data, 3);

	return 0;
}
