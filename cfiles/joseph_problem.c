#include <stdio.h>
#include <stdlib.h>

typedef struct node{
	int number;
	struct node *next;
}person;

//initialise function
person *initLink(int n) {
	//create head node
	person *head=(person*)malloc(sizeof(person));
	head->number = 1;
	head->next = NULL;
	
	// create body
	person *temp = head;
	for (int i = 2; i<=n; i++) {
		person *body = (person*)malloc(sizeof(person));
		body->number = i;
		body->next = NULL;
	//link all nodes together
		temp->next = body;
		temp = temp->next;
	}
	
	//at the end linke tail to head
	temp->next = head;
	
	return head;
}

void find_kill(person *head, int k,int m) {
	
	person *tail=head;
	//find the tail node 
	while ( tail->next!=head) {
		tail=tail->next;
	}
	
	//find the person with number k
	person *p=head;
	while ( p->number!=k) {
		tail=p;
		p=p->next;
	}
	
	//if p->next==p, all nodes are removed otherwise continue
	while( p->next != p) {
		for(int i=1; i<m; ++i) {
			tail = p;
			p = p->next;
		}

		tail->next = p->next;//remove p node;
		printf("removed number: %d\n",p->number);
		
		free(p);		
		p=tail->next;// next person becomes p node and continue;
	}
	
	printf("the last person :%d \n",p->number);
	free(p);
}




int main() {
	
	//initialise a object with length n
	printf("input node number n:\n");
	int n;
	scanf("%d",&n);
	person *obj_1=initLink(n);

	//input a start node
	printf("input start node 1<k<%d:\n",n);
	int k;
	scanf("%d",&k);
	
	//decide the count number
	printf("input m for count:\n");
	int m;
	scanf("%d",&m);

	//recall function
	find_kill(obj_1,k,m);
	
	return 0;
}
