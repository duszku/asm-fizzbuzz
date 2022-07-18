; Calculates number of characters in a NUL-terminated string and stores it in
; register RAX. String is expected to go into RDX before the subroutine call
_strlen:
        mov rax,0x00

    _strlen_loop:
        cmp rdx,0x00
        je _strlen_pool

        add rdx,0x01
        add rax,0x01
        jmp _strlen_loop

    _strlen_pool:
        ret


; Prints NUL-terminated string to the standard output. String is expected to
; be put in RDX before the subroutine call
_putstr:
        pusha
        call _strlen
        mov rsi,rdx
        mov rdx,rax
        mov rax,0x01
        mov rdi,0x01
        syscall
        popa
        ret