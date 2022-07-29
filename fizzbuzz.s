%define NUL 0x00
%define LF  0x0a

section .data
    s_hello_msg: db "Welcome to assembly fizz-buzz!",LF,NUL
    s_input_msg: db "Give a bound: ",NUL
    s_fizz_buzz: db "Fizz Buzz",NUL
    s_fizz:      db "Fizz",NUL
    s_buzz:      db "Buzz",NUL
    s_next:      db ", ",NUL

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
        call    atoi

        push    rax
        mov     rax,0x01

    main_loop:
        pop     rcx
        cmp     rcx,rax
        push    rcx
        je      main_pool

    main_if: ; is the number in RAX divisible by 15 (fizzbuzz)
        push    rax

        mov     ebx,0x0f
        cqo
        div     ebx
        cmp     rdx,0x00
        pop     rax
        jne     main_elif

        mov     rsi,s_fizz_buzz
        call    putstr
        jmp     main_fi

    main_elif: ; is the number in RAX divisible by 3? (fizz)
        push    rax

        mov     ebx,0x03
        cqo
        div     ebx
        cmp     rdx,0x00
        pop     rax
        jne     main_elif_2

        mov     rsi,s_fizz
        call    putstr
        jmp     main_fi

    main_elif_2: ; is the number in RAX divisible by 5? (buzz)
        push    rax

        mov     ebx,0x05
        cqo
        div     ebx
        cmp     rdx,0x00
        pop     rax
        jne     main_elif_3

        mov     rsi,s_buzz
        call    putstr
        jmp     main_fi

    main_elif_3:
        mov     rsi,s_bound_inp
        call    itoa
        call    putstr

    main_fi:
        mov     rsi,s_next
        call    putstr

        inc     rax
        jmp     main_loop

    main_pool:

        mov     rdi,0x00
        call    return_rdi


    return_rdi:
        mov     rax,0x3c
        syscall
