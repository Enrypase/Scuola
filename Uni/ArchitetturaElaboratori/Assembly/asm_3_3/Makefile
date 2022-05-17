AS_FLAGS = --32 -gstabs
LD_FLAGS = -m elf_i386

output: src/asm_3_3.s
	as $(AS_FLAGS) src/asm_3_3.s -o obj/asm_3_3.o
	ld $(LD_FLAGS) obj/asm_3_3.o -o bin/asm_3_3
clean:
	rm -f obj/*
	rm -f bin/*			