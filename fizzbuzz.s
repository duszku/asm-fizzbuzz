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

; globals and externs
global _start
extern _puts


section .data
        text1 db "Sample text 1",LF,NUL
        text2 db "Sample text 2",LF,NUL


section .text
_start:
        mov rax, text1
        call _puts

        mov rax, text2
        call _puts

        exit 0
