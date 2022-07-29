%define NUL 0x00
%define LF  0x0a

section .data
    s_hello_msg: db "Welcome to assembly fizz-buzz!",LF,NUL
    s_input_msg: db "Give a bound: ",NUL

    tst_1: db "This was a number",LF,NUL
    tst_2: db "This was not a number",LF,NUL

section .bss
    s_bound_inp: resb 0x09

section .text
    global _start

    %include "string.s"

    _start:
        ; Printing welcome message
        mov     rsi,s_hello_msg
        call    putstr
        mov     rsi,s_input_msg
        call    putstr

        ; Reading bound from stdin
        mov     rsi,s_bound_inp
        mov     rdx,0x09
        call    getstr

    if:
        call    isdec
        cmp     al,0x00
        je      else

        mov     rsi,tst_1
        jmp     fi

    else:
        mov     rsi,tst_2
    fi:
        call    putstr

        mov     rdi,0x00
        call    return_rdi


    return_rdi:
        mov     rax,0x3c
        syscall
