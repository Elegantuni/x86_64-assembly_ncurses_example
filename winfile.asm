includelib ".\pdcurses.lib"
extrn clear:proc
extrn mvprintw:proc
extrn endwin:proc
extrn time:proc
extrn srand:proc
extrn rand:proc
extrn cbreak:proc
extrn move:proc
extrn initscr:proc
extrn noecho:proc
extrn getch:proc
extrn exit:proc
extrn printf:proc
extrn refresh:proc
extrn winfile_cols:proc
extrn winfile_rows:proc

.data
playerposx dq 0
playerposy dq 0
rows dq 0
cols dq 0
randomnumber dq 0
player db "@", 0

.code
main proc
        push rbp
        mov rbp, rsp

	call winfile_cols
	sub rax, 1
	mov cols, rax

	call winfile_rows
	sub rax, 1
	mov rows, rax

        mov rcx, 0
        call time
        mov r11, rax

        mov rcx, r11
        call srand
	
        call rand
	mov randomnumber, rax

        mov rax, randomnumber
        mov rbx, cols
        xor rdx, rdx
        div rbx
        mov playerposx, rdx
        
        mov rax, randomnumber
        mov rbx, rows
        xor rdx, rdx
        div rbx
        mov playerposy, rdx

        call initscr

        call clear

        call noecho

        call cbreak
        
        mov rcx, playerposy
        mov rdx, playerposx
        mov r8, offset player
        call mvprintw

        mov rcx, playerposy
        mov rdx, playerposx
        call move

	call refresh

loop1:
        call getch
        mov rbx, 'q'
        cmp rbx, rax
        je end1

        mov rbx, 97
        cmp rbx, rax
        je processa

        mov rbx, 100
        cmp rbx, rax
        je processd

        mov rbx, 119
        cmp rbx, rax
        je processw

        mov rbx, 115
        cmp rbx, rax
        je processs

process:
        call clear

        mov rcx, playerposy
        mov rdx, playerposx
        mov r8, offset player
        call mvprintw

        mov rcx, playerposy
        mov rdx, playerposx
        call move

	call refresh
        jmp loop1

processa:
        mov rbx, playerposx
        sub rbx, 1
        cmp rbx, 0
        jl loopa
        jmp loopaend

loopa:
        mov rbx, 0

loopaend:
        mov rcx, rbx
        mov playerposx, rcx
        jmp process

processd:
        mov rbx, playerposx
        add rbx, 1
        cmp rbx, cols
        jg loo
        jmp loopdend

loo:
        mov rbx, cols

loopdend:
        mov rcx, rbx
        mov playerposx, rcx
        jmp process

processw:
        mov rbx, playerposy
        sub rbx, 1
        cmp rbx, 0
        jl loopw
        jmp loopwend

loopw:
        mov rbx, 0

loopwend:
        mov rcx, rbx
        mov playerposy, rcx
        jmp process

processs:
        mov rbx, playerposy
        add rbx, 1
        cmp rbx, rows
        jg loops
        jmp loopsend

loops:
        mov rbx, rows

loopsend:
        mov rcx, rbx
        mov playerposy, rcx
        jmp process

end1:
        call endwin

        mov rsp, rbp
        pop rbp

        mov rcx, 0
        call exit

main endp
end
