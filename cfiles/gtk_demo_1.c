/*
 *Author:@ yangspot.com
 */

#include <gtk/gtk.h>

//gcc gtk_demo_1.c `pkg-config --cflags --libs gtk+-3.0`

int main(int argc, char *argv[]) {
        //1.gtk initialisation
        gtk_init(&argc, &argv);
 
        //2.create a main window
        GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
        gtk_window_set_title(GTK_WINDOW(window),"Welcome");

        //3.1 create a vertical box
        GtkWidget *vbox = gtk_box_new(TRUE, 10);
        //3.2 put vertical box into window
        gtk_container_add(GTK_CONTAINER(window), vbox);
 
        //4.1.1 create a button
        GtkWidget *button1 = gtk_button_new_with_label("button1");
        //4.1.2 put button into box
        gtk_container_add(GTK_CONTAINER(vbox), button1);
 
        //4.2.1 create antoher button
        GtkWidget *button2 = gtk_button_new_with_label("button2");
        //4.2.2 put into box
        gtk_container_add(GTK_CONTAINER(vbox), button2);
 
       
        GtkWidget *button3 = gtk_button_new_with_label("button3");
       
        gtk_container_add(GTK_CONTAINER(vbox), button3);
 
        //5.print all components
        gtk_widget_show_all(window);
 
        //6. main loop
        gtk_main();
        return 0;
}