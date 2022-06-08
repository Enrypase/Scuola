.section .data # Inizio della sessione data, si definiscono variabili con valori

hello:
.ascii "Hello World!\n"
#.ascii  o .string
#.byte 255
#.long o .int, entrambi a 32 bit
#.char 255 in valore di carattere

# CALCOLARE LA LUNGHEZZA DELLA STRINGA:
hello_len:
.long . - hello

.section .text # Qui inizia il codice
.global _start # Inizio del programma per GAS, mentre main per GCC

# Corrispettivo del main
_start:
# SYSTEM CALL SCRITTURA
movl $4,%eax # Codice identificativo della system call
movl $1,%ebx # 1 corrisponde alla periferica del terminale

leal hello,%ecx #Prendi l'indirizzo in memoria dell'etichetta

movl hello_len,%edx # Lunghezza della stringa

int $0x80 # Interrupt 80, serve a dire alla CPU che stiamo facendo una determinata azione

#SYSTEM CALL NOTIFICA DI USCITA DAL PROCESSO
 movl $1,%eax # Codice identificativo della chiamata a sistema
 movl $0,%ebx # Valore del "return"

 int $0x80 # ""


 # COME SI COMPILA?
 # as Assembly.s -o assembly.o -> Fa un controllo sintattico e aggiunge le varie system call al programma
 # ld assembly.o -o assembly -> Genera un file eseguibile
