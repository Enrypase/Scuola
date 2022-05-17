# stringa:
# .ascii "Ciao 123"

# Come stampo un intero, però?
# Nella tabella ASCII i numeri iniziano da 48, quindi, per la singola cifra, basta sommare 48 al numero


# _start:
# etichetta1: 
# codice... # In assembly non esistono costrutti if-then-else, a questo servono le etichette. Creano blocchi di codice


# Salti condizionati:
# _start:
# ...
# cmp %eax, %ebx  # Alza i bit di EFLAGS
# jg etichetta    # Salta in base ai flag di EFLAGS specificati nell'istruzione di salto

# Primo esercizio
# Una variabile contiene il numero di studenti, la seconda gli studenti che stanno in auto. Voglio stampare il risultato a video
.section .data
titolo:
.ascii "Stringa di presentazione del programma...\n\n"
titolo_len:
.long . - titolo

risposta:
.ascii "Totale auto necessarie: "
risposta_len:
.long . - risposta

numStudenti:
.long 85

studentiPerAuto:
.long 5

numAuto:
.ascii "000\n"  # Sto allocando lo spazio per i numeri che voglio stampare (avrò al massimo 999 auto)

.section .text
.global _start

_start:
movl numStudenti, %eax
movl studentiPerAuto, %ebx

divb %bl                        # In valore è piccolo, contenuto solo in B LOW - max valore 2^8 = 256 AL -> Numero di macchine AH -> Resto
# Aggiungiamo 1 se il resto > 0
cmpb $0, %ah
# Se non c'è resto continua
je continua
# Altrimenti, se c'è resto...
incb %al

continua:
xorb %ah, %ah                   # Azzeriamo il contenuto del resto, non ci interessa

movl $10, %ebx
divb %bl

addb $48, %ah                   # Ora abbiamo un valore nel carattere ASCII delle unità del risultato

leal numAuto, %esi              # Per le stringhe usiamo ESI / EDI
movb %ah, 2(%esi)               # Stiamo scrivendo qui "00X\n"

xorb %ah, %ah
divb %bl 
addb $48, %ah
movb %ah, 1(%esi)               # Stiamo scrivendo qui "0X0\n"
# Inseriamo uno spazio al posto del primo carattere della stringa
movb $32, (%esi)
# Il contenuto della variabile va bene, ora contiene il valore in carattere ASCII del risultato

stampa:
# Sys call
movl $4, %eax
movl $1, %ebx
leal titolo, %ecx
movl titolo_len, %edx
int $0x80
# Dopo l'interrupt i general purpose vengono azzerati
movl $4, %eax
movl $1, %ebx
leal risposta, %ecx
movl risposta_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
leal numAuto, %ecx
movl $4, %edx
int $0x80
# Il programma non è ancora concluso. Manca il return (syscall di uscita per lo scheduler del S.O.)
movl $1, %eax
xorl %ebx, %ebx
int $0x80


