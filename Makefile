ASM=nasm
LNK=ld
A_FLAGS=-f elf64

SRC=fizzbuzz.s

.PHONY: fizzbuzz clean

fizzbuzz:
		${ASM} ${A_FLAGS} -o $@.o ${SRC}
		${LNK} -o $@ $@.o

clean:
		rm -rf *.o
