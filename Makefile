ASM=nasm
FORMAT=elf64

LINK=ld

SRC=fizzbuzz.s
OBJ=${SRC:.s=.o}

.PHONY: clean fizzbuzz

fizzbuzz:
	${ASM} -f ${FORMAT} ${SRC}
	${LINK} -o $@ ${OBJ}

clean:
	rm -rf *.o
