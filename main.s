section .data
    welcome_msg db "Welcome to fizzbuzz!",10,"How far do you wish to go: "

section .bss
    limit resb 16

section .text
    global _start

    _start:

    _putstr:
        pusha
        mov rax,0x01
        mov rdi,0x01
        mov rdx,0xf0
        syscall
        popa
        ret