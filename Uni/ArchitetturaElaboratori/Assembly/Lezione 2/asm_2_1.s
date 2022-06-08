.section .data
testo:
.ascii "\nScrivere un programma Assembly che sommi i numeri 100, 33 e 68 e metta il risultato in una  variabile chiamata 'somma'. Stampare a monitor il risultato\n\nLa somma dei tre numeri è: "
testo_len:
.long . - testo

# I numeri saranno passati con metodo indirizzamento diretto (tramite IR), dichiariamo la variabile somma inizializzandola a 0
somma:
.ascii "000\n"

.section .text
.global _start

_start:
xorl %eax, %eax         # Resettiamo il registro eax
addl $100, %eax         # Sommiamo il numero 100 al registro appena resettato
addl $33, %eax          # Ci aggiungiamo 33
addl $68, %eax          # Ci aggiungiamo 68

leal somma, %ebx        # Salviamo l'indirizzo della variabile "titolo" in EBX
movb $10, %cl

# Ora il risultato della somma è in eax < 255 quindi AL
divb %cl
addb $48, %ah
movb %ah, 2(%ebx)       # Modifichiamo la cifra delle unità
xorb %ah, %ah

divb %cl
addb $48, %ah
movb %ah, 1(%ebx)       # Modifichiamo la cifra delle decine
xorb %ah, %ah

divb %cl
addb $48, %ah
movb %ah, (%ebx)        # Modifichiamo la cifra delle centinaia
xorb %ah, %ah
# Interrupt per lo stampaggio a schermo
movl $4, %eax
movl $1, %ebx
leal testo, %ecx
movl testo_len, %edx
int $0x80
# Interrupt per lo stampaggio a schermo
movl $4, %eax
movl $1, %ebx
leal somma, %ecx
movl $4, %edx
int $0x80
# Interrupt per la fine del programma
movl $1, %eax
xorl %ebx, %ebx
int $0x80


