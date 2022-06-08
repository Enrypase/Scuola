AS_FLAGS = --32 -gstabs
LD_FLAGS = -m elf_i386
SRCS = {sorgente1.s, sorgente2.s}				# Esiste un modo per compilarle tutte

all: bin/asm_3 # Così quando si lancia make, all -> asm_3 -> asm_3.o -> asm_3 -> all

obj/asm_3.o: src/asm_3.s						# Compilazione solo quando nel sorgente sono state fatte modifiche
	as $(AS_FLAGS) src/asm_3.s -o obj/asm_3.o
src/asm_3: obj/asm_3.o							# Regola eseguita solo dopo quella precedente
	ld $(LD_FLAGS) obj/asm_3.o -o bin/asm_3
clean:											# Regola riconosciuta per rimuovere dai file oggetto
	rm -f obj/*
	rm -f src/*			