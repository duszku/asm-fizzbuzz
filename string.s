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

; Reads string from stdin and NUL-terminates it
; Expects destination in RSI and maximal length (including NUL) in RDX
; Preserves state of all registers
getstr:
        push    rax
        push    rdi
        push    rdx
        push    rsi
        mov     rax, 0x00   ; sys_read
        mov     rdi, 0x00   ; stdin

        sub     rdx, 0x01
        syscall

        add     rsi, rdx
        add     rsi, 0x01
        mov     byte [rsi], 0x00

        pop     rsi
        pop     rdx
        pop     rdi
        pop     rax
        ret
