; Calculates length of a NUL-terminated string
; Expects the string to be put in RSI
; Outputs string length to RDX
strlen:
        push    rsi
        mov     rdx, 0x00

    strlen_loop:
        cmp     byte [rsi], 0x00
        je      strlen_pool

        add     rsi, 0x01
        add     rdx, 0x01
        jmp     strlen_loop

    strlen_pool:
        pop     rsi
        ret

; Prints NUL-terminated string to stdout
; Expects string in RSI
; Preserves state of all registers
putstr:
        push    rax
        push    rdi
        mov     rax, 0x01   ; sys_write
        mov     rdi, 0x01   ; stdout

        call    strlen
        syscall

        pop     rdi
        pop     rax
        ret
