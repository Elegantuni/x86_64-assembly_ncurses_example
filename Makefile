playerandtest1:
	gcc -o playerandtest1 main.s -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -lncurses -ltinfo -ldl -static

clean:
	rm -f playerandtest1

