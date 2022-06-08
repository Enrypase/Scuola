.section .data
testo: .ascii "Scrivere il programma Assembly equivalente al seguente algoritmo C per il calcolo del MCD di due numeri naturali.\nSi assuma che i parametri 'a' e 'b' siano nei registri EAX ed EBX.\n\n"
testo_len: .long . - testo
risultato: .ascii "MCD calcolato: "
risultato_len: .long . - risultato
calcolato: .ascii "000\n"
.section .text
.global _start

_start:
movl $4, %eax
movl $1, %ebx
leal testo, %ecx
movl testo_len, %edx
int $0x80
# Sposto i parametri nei due registri
movl $5, %eax
movl $255, %ebx
# Inizio traduzione dell'algoritmo
cmpl $0, %eax
jne secondoIf
cmpl $0, %ebx
jne terzoIf
movl $1, %ebx
jmp fine

secondoIf:
cmpl $0, %ebx
jne terzoIf
movl %eax, %ebx
jmp fine

terzoIf:
cmpl $0, %eax
je fine
inizioLoop:
cmpl %eax, %ebx
je fine
jl else
subl %eax, %ebx
jmp inizioLoop
else:
subl %ebx, %eax
jmp inizioLoop
fine:
leal calcolato, %esi
xorb %ah, %ah
movb %bl, %al
movb $10, %bl

div %bl
addb $48, %ah
movb %ah, 2(%esi)

xorb %ah, %ah
div %bl
addb $48, %ah
movb %ah, 1(%esi)

xorb %ah, %ah
div %bl
addb $48, %ah
movb %ah, (%esi)

movl $4, %eax
movl $1, %ebx
leal risultato, %ecx
movl risultato_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
leal calcolato, %ecx
movl $4, %edx
int $0x80

movl $1, %eax
xorl %ebx, %ebx
int $0x80

