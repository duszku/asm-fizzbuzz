; asm-fizzbuzz, fizzbuzz in x86_64 assembly
; Copyright (C) 2022 duszku
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

%include "consts.s"

global _puts
global _putu
global _atoi

section .bss
        putuBuffer resb 256

section .text

; prints string pointed to by value of RAX to stdout
_puts:
        push rax
        mov rbx, 0

    ; finding length of string (in RBX)
    _putsLoop:
        inc rax
        inc rbx
        mov cl, [rax]
        cmp cl, NUL
        jne _putsLoop

        ; sys_write to stdout
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        pop rsi
        mov rdx, rbx
        syscall

        ret

; converts number in RAX to a string and stores it in putuBuffer
_itoa:
        mov rbx, 10
        mov rsi, putuBuffer

    ; writing REVERSED string to putuBuffer
    _itoaLoop:
        mov rdx, 0
        div rbx

        add rdx, '0'
        mov byte [rsi], dl
        inc rsi

        cmp rax, 0
        jne _itoaLoop

        mov byte [rsi], NUL
        dec rsi

        mov rcx, putuBuffer

    ; reversing string stored in putuBuffer
    _itoaReverse:
        ; swapping
        mov dl, byte [rcx]
        mov dh, byte [rsi]
        mov byte [rcx], dh
        mov byte [rsi], dl

        inc rcx
        dec rsi

        cmp rcx, rsi
        jle _itoaReverse

        ret

; prints number in RAX to stdout
_putu:
        call _itoa
        mov rax, putuBuffer
        call _puts
        ret

; if value in dl is not a digit, calls SYS_EXIT with code 1
_isDigit:
        cmp dl, '0'
        jge _isDigitUpper

        exit 1

    _isDigitUpper:
        cmp dl, '9'
        jle _isDigitRet

        exit 1

    _isDigitRet:
        ret

; converts string pointed by RBX to number and stores it in RAX
_atoi:
        mov rax, 0
        mov rdx, 0

    _atoiLoop:
        mov dl, byte [rbx]
        cmp dl, NUL
        je _atoiEnd

        call _isDigit
        imul rax, 10
        sub dl, '0'
        add rax, rdx
        inc rbx

        jmp _atoiLoop

    _atoiEnd:
        ret
