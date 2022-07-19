section .data
    msg_1:  db "Welcome to Assembly fizzbuzz!",0x0a,0x00
    msg_2:  db "Enter a number: ",0x00

section .text
    global  _start

    %include "string.s"

    _start:
        mov     rsi, msg_1
        call    putstr

        mov     rsi, msg_2
        call    putstr

        mov     rax, 0x3c
        mov     rdi, 0x00
        syscall
