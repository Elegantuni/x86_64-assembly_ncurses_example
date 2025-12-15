#include <sys/ioctl.h>
#include <unistd.h>

unsigned short ioctl_row(void)
{
	struct winsize w;
	unsigned short w_name;

	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
	w_name = w.ws_row;

	return w_name;
}

unsigned short ioctl_col(void)
{
	struct winsize w;
	unsigned short w_name;

	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
	w_name = w.ws_col;

	return w_name;
}

