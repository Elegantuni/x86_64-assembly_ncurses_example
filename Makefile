playerandtest1:
	gcc -o w_c.o -c w.c
	gcc -o playerandtest1 main.s w_c.o -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -lncurses -ltinfo -ldl -static

clean:
	rm -f playerandtest1 w_c.o

