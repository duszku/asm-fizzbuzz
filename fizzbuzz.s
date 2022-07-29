%define NUL 0x00
%define LF  0x0a

section .data
    s_hello_msg: db "Welcome to assembly fizz-buzz!",LF,NUL
    s_input_msg: db "Give a bound: ",NUL

    tst_num: db "113",NUL
    tst: db "use wc -l on me",LF,NUL

section .bss
    s_bound_inp: resb 0x09

section .text
    global _start

    %include "string.s"

    _start:
;        ; Printing welcome message
;        mov     rsi,s_hello_msg
;        call    putstr
;        mov     rsi,s_input_msg
;        call    putstr
;
;        ; Reading bound from stdin
;        mov     rsi,s_bound_inp
;        mov     rdx,0x09
;        call    getstr
;        call    atoi

        mov     rsi,tst_num
        call    atoi

        mov     rsi,tst
    for:
        cmp     rax,0x00
        je      rof

        call    putstr
        sub     rax,0x01
        jmp for

    rof:

        mov     rdi,0x00
        call    return_rdi


    return_rdi:
        mov     rax,0x3c
        syscall
