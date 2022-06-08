# Debugging del programma:
# as --32 -gstabs asm_3.s -o asm_3.o
# --32 -> Compilazione per 32 bit | -gstabs -> Tag per debugging
# ld -m elf_i386 asm_3.o -o asm_3
# -m elf_i386 -> Linko le librerie a 32 bit

# ddd -> Interfaccia grafica per debugging
# STEP -> Di riga in riga
# NEXT -> Salta la funzione (non ci entra dentro per debug)

# gdb è quello consigliato
# gdb nomeEseguibile
# con break numeroRiga setto i breakpoint
# con run parte il programma
# con list vedo le 5 righe precedenti e 5 successive al breakpoint
# con step/next avanzo
# con continue vado al prossimo breakpoint
# con info registers vedo il valore dei registri
# con p/d $nomeRegistro stampo il valore il decimale d, esadecimale x, binario t del registro
# con x/lunghezzab &nomeVariabile con & trovo l'indirizzo in memoria e gli stampo i successivi byte specificati

# Makefile ci aiuta a automatizzare le fasi di compilazione
# Per utilizzare Makefile:
# make <nomeEtichetta>

#Tutti i file sorgente vanno in una cartella, oggetto in apposita ed eseguibili in apposita
# (obj/src/bin)
# make -j8 -> Paralellizza la compilazione su 8 thread


# ES 2 - Esercizio utilizzato come esempio:

#Scrivere un programma Assembly che confronti 2 numeri caricati nei registri EAX ed EBX
#e stampi una stringa che indichi quale sia il maggiore ed il minore oppure indichi che i
#due numeri sono uguali.

.section .data

domanda1:
  .ascii "Inserisci il primo numero: "

domanda1_len:
  .long . - domanda1

domanda2:
  .ascii "Inserisci il secondo numero: "

domanda2_len:
  .long . - domanda2

num1:
  .ascii "0000"

num1_len:
  .long . - num1

num2:
  .ascii "0000"

num2_len:
  .long . - num2

maggiore:
  .ascii " è maggiore di "

maggiore_len:
  .long . - maggiore

minore:
  .ascii " è minore di "

minore_len:
    .long . - minore

uguale:
  .ascii " è uguale a "

uguale_len:
  .long . - uguale

a_capo:
  .ascii "\n"

a_capo_len:
  .long . - a_capo

.section .text
  .global _start

_start:

  movl $4, %eax
  movl $1, %ebx
  leal domanda1, %ecx
  movl domanda1_len, %edx
  int $0x80

  #scanf
  movl $3, %eax
  movl $1, %ebx
  leal num1, %ecx
  movl num1_len, %edx
  incl %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal domanda2, %ecx
  movl domanda2_len, %edx
  int $0x80

  #scanf2
  movl $3, %eax
  movl $1, %ebx
  leal num2, %ecx
  movl num2_len, %edx
  incl %edx
  int $0x80

  movl num1, %eax
  movl num2, %ebx
  cmp %eax, %ebx

  jg greater
  jl less

equals:
  movl $4, %eax
  movl $1, %ebx
  leal num1, %ecx
  movl $4, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal uguale, %ecx
  movl uguale_len, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal num2, %ecx
  movl $4, %edx
  int $0x80

  jmp return

greater:
  movl $4, %eax
  movl $1, %ebx
  leal num2, %ecx
  movl $4, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal maggiore, %ecx
  movl maggiore_len, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal num1, %ecx
  movl $4, %edx
  int $0x80

  jmp return

less:
  movl $4, %eax
  movl $1, %ebx
  leal num2, %ecx
  movl $4, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal minore, %ecx
  movl minore_len, %edx
  int $0x80

  movl $4, %eax
  movl $1, %ebx
  leal num1, %ecx
  movl $4, %edx
  int $0x80

  jmp return

return:
  #stampo a capo
  movl $4, %eax
  movl $1, %ebx
  leal a_capo, %ecx
  movl a_capo_len, %edx
  int $0x80
  
  movl $1, %eax
  movl $0, %ebx
  int $0x80
