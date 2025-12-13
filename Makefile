playerandtest1:
	gcc -o playerandtest1 main.s /usr/lib64/libncurses.a /usr/lib64/libtinfo.a -static

clean:
	rm -f playerandtest1

