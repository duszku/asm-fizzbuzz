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

IS_FIZZ equ 0x01
IS_BUZZ equ 0x02

; globals and externs
global _start

extern _puts
extern _putu

section .bss
        printFizzbuzzFlags resb 1

section .data
        fizz db "Fizz",NUL
        buzz db "Buzz",NUL
        next db LF,NUL

section .text
_start:
        mov rcx, 10
        call _printFizzbuzz

        mov rcx, 12
        call _printFizzbuzz

        mov rcx, 13
        call _printFizzbuzz

        mov rcx, 15
        call _printFizzbuzz

        exit 0

; prints either value in RCX, "fizz" or "buzz" according to rules
_printFizzbuzz:
        mov byte [printFizzbuzzFlags], 0

        mov rax, rcx
        mov rbx, 3
        call _divisor
        jne check_buzz

        or byte [printFizzbuzzFlags], IS_FIZZ

    check_buzz:
        mov rax, rcx
        mov rbx, 5
        call _divisor
        jne printing

        or byte [printFizzbuzzFlags], IS_BUZZ

    printing:
        cmp byte [printFizzbuzzFlags], 0
        je printNumber

        mov dl, byte [printFizzbuzzFlags]
        and dl, IS_FIZZ
        cmp dl, IS_FIZZ
        jne printBuzz

        mov rax, fizz
        call _puts

    printBuzz:
        mov dl, byte [printFizzbuzzFlags]
        and dl, IS_BUZZ
        cmp dl, IS_BUZZ
        jne printNext

        mov rax, buzz
        call _puts
        jmp printNext

    printNumber:
        mov rax, rcx
        call _putu

    printNext:
        mov rax, next
        call _puts
        ret

; checks if value in RAX is divisible by value in RBX
_divisor:
        mov rdx, 0
        div rbx
        cmp rdx, 0
        ret
