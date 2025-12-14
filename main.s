#include "ncurses.h"

.data
player:
	.ascii "@\0"
	.lcomm playerposx, 8
	.lcomm playerposy, 8

.text
.globl main
main:
	push %rbp
	mov %rsp, %rbp

	mov $0, %rax
	mov $0, %rdi
	call time
	mov %rax, %rdi

	mov $0, %rax
	call srand

	mov $0, %rax
	call rand
	xor %rdx, %rdx
	mov $79, %rcx
	div %rcx
	mov %rdx, (playerposx)

	mov $0, %rax
	call rand
	xor %rdx, %rdx
	mov $23, %rcx
	div %rcx
	mov %rdx, (playerposy)

	mov $0, %rax
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
	cmp $79, %rbx
	jg loopd
	jmp loopdend

loopd:
	mov $79, %rbx

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
	cmp $23, %rbx
	jg loops
	jmp loopsend

loops:
	mov $23, %rbx

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

