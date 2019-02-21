#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct xxxx;
typedef struct xxxx NODE;
struct xxxx {
	int id;
	char name[16];
	NODE *next;
};

NODE mmmm = { 0 };

void addhead(NODE *bbbb) {
	bbbb->next = mmmm.next; 
	mmmm.next = bbbb;
}

void addend(NODE *cccc) {
	// points to the head
	NODE *buff = &mmmm;

	//find the end
	while (buff->next){
		buff = buff->next;
	} 

	buff->next = cccc;
	cccc->next = NULL;
}

int main() {
	
	NODE *b1 = (NODE*)malloc(sizeof(NODE));
	b1->id = 1;
	strcpy(b1->name, "lamborghni");

	NODE *b2 = (NODE*)malloc(sizeof(NODE));
	b2->id = 2;
	strcpy(b2->name, "ferrari");

	addhead(b1);
	addend(b2);

	//list all data
	NODE *pp;
	//a temporary
	pp =&mmmm;
	 while(pp->next){
	 	printf("id: %d\tname :%s\n",pp->id, pp->name);
		pp = pp->next;
	}
	//print the last one
	printf("id: %d\tname :%s\n",pp->id, pp->name);

	return 0;
}
