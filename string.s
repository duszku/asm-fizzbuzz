; Calculates length of a NUL-terminated string pointed to by value of RSI.
; Puts calculated value into RDX
strlen:
        push    rsi
        mov     rdx,0x00 ; length of string initialized to 0
    strlen_loop:
        cmp     byte [rsi],0x00
        je      strlen_pool

        add     rsi,0x01
        add     rdx,0x01
        jmp     strlen_loop

    strlen_pool:
        pop     rsi
        ret

; Prints NUL-terminated string pointed to by value of RSI to stdout.
putstr:
        push    rax
        push    rdi
        mov     rax,0x01 ; sys_write
        mov     rdi,0x01 ; stdout

        call    strlen   ; length of RSI put in RDX
        syscall          ; syscall execution

        pop     rdi
        pop     rax
        ret
