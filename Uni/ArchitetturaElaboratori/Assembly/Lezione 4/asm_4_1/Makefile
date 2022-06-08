AS_FLAGS = --32 -gstabs
LD_FLAGS = -m elf_i386

all: bin/asm_4_1

obj/asm_4_1.o: src/asm_4_1.s
	as $(AS_FLAGS) src/asm_4_1.s -o obj/asm_4_1.o
bin/asm_4_1: obj/asm_4_1.o
	ld $(LD_FLAGS) obj/asm_4_1.o -o bin/asm_4_1
clean:
	rm -f obj/*
	rm -f bin/*			