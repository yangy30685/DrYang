myapp: cc2.o cc3.o 
	gcc -o myapp cc2.o cc3.o
cc2.o:cc2.c cc1.h
	gcc -c cc2.c
cc3.o:cc3.c cc1.h
	gcc -c cc3.c
clean:
	rm -rf *.o cc2
