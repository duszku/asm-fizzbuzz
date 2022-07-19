section .data
    msg_1:  db "Welcome to Assembly fizzbuzz!",0x0a,0x00
    msg_2:  db "Enter a number: ",0x00
    msg_3:  db "It was a number!",0x00
    msg_4:  db "That is not a number!",0x00

section .bss
    limit:  resb 0xf1

section .text
    global  _start

    %include "string.s"

    _start:
        mov     rsi, msg_1
        call    putstr

        mov     rsi, msg_2
        call    putstr

        mov     rsi, limit
        mov     rdx, 0xf1
        call    getstr

        call    putstr

        call    isnumber
    if:
        cmp     rax, 0x01
        jne     else

        mov     rsi, msg_3
        call    putstr
        jmp     fi
    else:
        mov     rsi, msg_4
        call    putstr
        jmp     fi
    fi:

        mov     rax, 0x3c
        mov     rdi, 0x00
        syscall
