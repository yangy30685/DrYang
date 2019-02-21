#include <gtk/gtk.h>
/**https://blog.csdn.net/lianghe_work/article/details/47041153
 * gcc c2.c -o c2 `pkg-config --cflags --libs gtk+-3.0`
 * gcc `pkg-config --cflags gtk+-3.0` -o example-0 example-0.c `pkg-config --libs gtk+-3.0`
 * yangspot.com
 * */

int main ( int argc, char *argv[] ) {
  //gtk initialisation
  gtk_init (&argc, &argv);

  // Create a main window
  // main window is a container 
  GtkWidget *mainwin;
  mainwin = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  //set title
  gtk_window_set_title(GTK_WINDOW(mainwin), "yangspot.com");

  //create horizontal box
  // ture must be capital
  GtkWidget *hori_box = gtk_box_new(TRUE,100);
  //put box into window
  gtk_container_add(GTK_CONTAINER(mainwin),hori_box);

  //create button
  GtkWidget *button_1 = gtk_button_new_with_label("btn 1 !");
  //put button into container
  gtk_container_add(GTK_CONTAINER(hori_box), button_1);

  GtkWidget *button_2 = gtk_button_new_with_label("btn 2 !");
  gtk_container_add(GTK_CONTAINER(hori_box), button_2);

  GtkWidget *button_3 = gtk_button_new_with_label("btn 3 !");
  gtk_container_add(GTK_CONTAINER(hori_box), button_3);

  GtkWidget *button_4 = gtk_button_new_with_label("btn 4 !");
  gtk_container_add(GTK_CONTAINER(hori_box), button_4);


  //show the button
  //gtk_widget_show(button);
  //show the window
  //gtk_widget_show(mainwin);
  
  //alternative show all
  gtk_widget_show_all(mainwin);
  // Enter the main event loop, and wait for user interaction
  
  gtk_main ();

  // The user lost interest
  return 0;
}
