ASM=nasm
FLAGS=-f elf64 -g

LINK=ld

SRC=
OBJ=${SRC:.s=.o}
BINDIR=bin

.PHONY: all

all: fizzbuzz clean

.s.o:
	${ASM} ${FLAGS} $<

fizzbuzz: ${BINDIR} ${OBJ}
	${LINK} -o ${BINDIR}/$@ ${OBJ}

clean:
	rm -rf *.o

${BINDIR}:
	mkdir bin
