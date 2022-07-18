section .data
    welcome_msg db "Welcome to fizzbuzz!",0x0a,"How far do you wish to go: ",0x00

section .bss
    limit resb 0xf0

section .text
    global _start

    _start:
        mov rdx,welcome_msg
        call _putstr

        mov rax,0x3b
        mov rdi,0x00

    %include strings.s