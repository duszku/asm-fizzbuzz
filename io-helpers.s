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

%define NUL 0

global _puts

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
        mov rax, 1
        mov rdi, 1
        pop rsi
        mov rdx, rbx
        syscall

        ret
