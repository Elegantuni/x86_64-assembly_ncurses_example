#include "ncurses.h"
#include "w.h"

.data
player:
	.ascii "@\0"
stdscr_now:
	.ascii "stdscr\0"

	.lcomm playerposx, 8
	.lcomm playerposy, 8
	.lcomm rows, 8
	.lcomm cols, 8

.text
.globl main
main:
	push %rbp
	mov %rsp, %rbp

	mov $0, %rax
	call ioctl_col
	mov %rax, %r8
	sub $1, %r8
	mov %r8, (cols)

	mov $0, %rax
	call ioctl_row
	mov %rax, %r9
	sub $1, %r9
	mov %r9, (rows)

	rdrand %rax
	mov (cols), %rbx
	xor %rdx, %rdx
	div %rbx
	mov %rdx, (playerposx)
	
	rdrand %rax
	mov (rows), %rbx
	xor %rdx, %rdx
	div %rbx
	mov %rdx, (playerposy)

	mov $0, %rax
	mov $stdscr_now, %rdi
	mov (cols), %rsi
	mov (rows), %rdx
	call initscr

	mov $0, %rax
	call clear

	mov $0, %rax
	call noecho

	mov $0, %rax
	call cbreak
	
	mov $0, %rax
	mov (playerposy), %rdi
	mov (playerposx), %rsi
	mov $player, %rdx
	call mvprintw

	mov $0, %rax
	mov (playerposy), %rdi
	mov (playerposx), %rsi
	call move

loop1:
	mov $0, %rax
	call getch
	mov $113, %rbx
	cmp %rax, %rbx
	je end

	mov $97, %rbx
	cmp %rax, %rbx
	je processa

	mov $100, %rbx
	cmp %rax, %rbx
	je processd

	mov $119, %rbx
	cmp %rax, %rbx
	je processw

	mov $115, %rbx
	cmp %rax, %rbx
	je processs

process:
	mov $0, %rax
	call clear

	mov $0, %rax
	mov (playerposy), %rdi
	mov (playerposx), %rsi
	mov $player, %rdx
	call mvprintw

	mov $0, %rax
	mov (playerposy), %rdi
	mov (playerposx), %rsi
	call move
	jmp loop1

processa:
	mov (playerposx), %rbx
	sub $1, %rbx
	cmp $0, %rbx
	jl loopa
	jmp loopaend

loopa:
	mov $0, %rbx

loopaend:
	mov %rbx, %rcx
	mov %rcx, (playerposx)
	jmp process

processd:
	mov (playerposx), %rbx
	add $1, %rbx
	cmp (cols), %rbx
	jg loopd
	jmp loopdend

loopd:
	mov (cols), %rbx

loopdend:
	mov %rbx, %rcx
	mov %rcx, (playerposx)
	jmp process

processw:
	mov (playerposy), %rbx
	sub $1, %rbx
	cmp $0, %rbx
	jl loopw
	jmp loopwend

loopw:
	mov $0, %rbx

loopwend:
	mov %rbx, %rcx
	mov %rcx, (playerposy)
	jmp process

processs:
	mov (playerposy), %rbx
	add $1, %rbx
	cmp (rows), %rbx
	jg loops
	jmp loopsend

loops:
	mov (rows), %rbx

loopsend:
	mov %rbx, %rcx
	mov %rcx, (playerposy)
	jmp process

end:
	mov $0, %rax
	call endwin

	mov %rbp, %rsp
	pop %rbp

	mov $0, %rax
	mov $0, %rdi
	call exit

