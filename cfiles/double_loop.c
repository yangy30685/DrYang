/*
 *Author:@ yangspot.com
 */

#include <stdio.h>
#include <stdlib.h>

//define a struct type DL
typedef struct double_loop {
    struct double_loop *previous;
    double data;
    struct double_loop *next;
}DL;

//initialise a double direction linked list
DL * init_double_loop(DL *head){
    
    //create head for the list
    head = (DL*)malloc(sizeof(DL));
    head->previous = NULL;
    head->data = 0.1;
    head->next = NULL;

    //create list of node
    //temp is used to point the different position of the list
    DL* temp=head;
    
    for (int i=0; i<5 ;++i) {
        //apply for space for each node
        DL *data_body=(DL*)malloc(sizeof(DL));
        
        //head node points to next node 
        temp->next = data_body;
        data_body->next = NULL;
        data_body->data = i+1.1;//assign value
        data_body->previous = temp;
        //update temp position
        //temp=data_body;
        temp=temp->next;
    }
    return head;
}

//insert a data node
DL *insert_node(DL *head, int position, double data) {
    //apply a new space for the inserted node
    DL *temp = (DL*)malloc(sizeof(DL));
    temp->data = data;
    temp->next = NULL;
    temp->previous = NULL;
    //1st position
    if (1 == position) {
        temp->next = head;
        head->previous = temp;
        head = temp;
    } else {
        //last node situation
        DL* body_pointer = head;
        //search for positon
        for (int i=1; i<position-1; ++i) {
            body_pointer = body_pointer->next;
        } 
       
        if (body_pointer->next == NULL) {
            body_pointer->next = temp;
            temp->previous=body_pointer;
        } else {
            temp->next = body_pointer->next;
            temp->previous = body_pointer;
            body_pointer->next = temp;
            body_pointer->next->previous = temp;
        }
    }
    return head;
}

//delete a node
DL* delete_node(DL *head, int position) {
    DL *temp = head;
    if ( 1 == position) {
        head = temp->next;
        head->previous = NULL;
    } else {
        for (int i = 0; i < position-1; ++i) {
                
                temp=temp->next;
                //check if reach the last node
                if( temp->next == NULL ) {
                    temp->previous->next = NULL;
                    free(temp);
                    printf("reach the end and delete the last node\n");
                    return head;
                }
               
        }
        temp->previous->next = temp->next;
        temp->next->previous = temp->previous;  
    }
    free(temp);
    return head;
}

void show(DL *head) {
    DL* temp=head;
    while(temp) {
        //print last node data
        if (temp->next == NULL){
            printf("data->%f\n",temp->data);
        } else {
            printf("data->%f\t",temp->data);
        }
        temp = temp->next;
    }
    //reset temp at the end
    temp = head;
}

int main() {
    //create the 1st data node
    DL *a=NULL;
    //use it to initialise a list
    a = init_double_loop(a);
    //print out all data
    show(a);
    
    //insert a node 
    a = insert_node(a, 1, 99.99);
    show(a);

    //delete a node with input position
    //if the position beyoud the scale delete the last node 
    a = delete_node(a,9);
    show(a);
    return 0;
}