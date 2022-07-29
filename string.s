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

; Reads string from stdin and and NUL-terminates it. Destination should be
; pointed to by value of RSI and maximal length + 1 should be in RDX
getstr:
        push    rax
        push    rdi
        push    rsi

        mov     rax,0x00 ; sys_read
        mov     rdi,0x00 ; stdin
        syscall

        add     rsi,rax
        sub     rsi,0x01
        mov     byte [rsi],0x00 ; NUL-terminating

        pop     rsi
        pop     rdi
        pop     rax
        ret

; Verifies whether string pointed to by value of RSI is composed only of decimal
; digits and NUL. Outputs either 0 (false) or 1 (true) to AL
isdec:
        push    rsi
    isdec_loop:
        cmp     byte [rsi],0x00
        je      isdec_pool

        cmp     byte [rsi],'0'
        jl      isdec_ret_0
        cmp     byte [rsi],'9'
        jg      isdec_ret_0

        add     rsi,0x01
        jmp     isdec_loop

    isdec_pool:
        mov     al,0x01
        pop     rsi
        ret

    isdec_ret_0:
        mov     al,0x00
        pop     rsi
        ret

; Converts NUL-terminated string pointed to by value of RSI to integer and
; outputs it to RAX. If said string cannot be converted, outputs 0.
atoi:
        push    rbx
        push    rsi


        call    isdec
        cmp     al,0x00
        mov     rax,0x00
        je      atoi_pool

    atoi_loop:
        mov     rbx,byte [rsi] ; take current character
        cmp     rbx,0x00
        je      atoi_pool

        mul     rax,0x0a ; multiply accumulator by 10
        sub     rbx,'0'  ; subtract the offset
        add     rax,rbx  ; increase by new digit
        inc     rsi

        jmp     atoi_loop

    atoi_pool:
        pop     rsi
        pop     rbx
        ret
