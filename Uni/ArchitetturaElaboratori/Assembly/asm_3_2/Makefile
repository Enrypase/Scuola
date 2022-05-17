AS_FLAGS = --32 -gstabs
LD_FLAGS = -m elf_i386

output: src/asm_3_2.s
	as $(AS_FLAGS) src/asm_3_2.s -o obj/asm_3_2.o
	ld $(LD_FLAGS) obj/asm_3_2.o -o bin/asm_3_2
clean:
	rm -f obj/*
	rm -f bin/*			