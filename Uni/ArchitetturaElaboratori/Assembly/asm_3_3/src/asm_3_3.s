.section .data
descrizione: .ascii "Scrivere un programma Assembly che calcoli il fattoriale di un numero naturale letto da tastiera e ne stampi a schermo il risultato\n\n"
descrizione_len: .long . - descrizione
risultatoM: .ascii "Il fattoriale del numero inserito è: "
risultatoM_len: .long . - risultatoM
numero: .ascii "0000000000\n"
numero_len: .long . - numero
richiestaInput1: .ascii "Inserire il numero di cui calcolare il fattoriale: "
richiestaInput1_len: .long . - richiestaInput1
input1: .ascii "0000000000"
input1_int: .long 0
erroreM: .ascii "Il fattoriale del numero inserito è troppo grande > 32 bit\n"
erroreM_len: .long . - erroreM

.section .text
.global _start

_start:
movl $4, %eax
movl $1, %ebx
leal descrizione, %ecx
movl descrizione_len, %edx
int $0x80
# In ebx viene messo il numero
movl $4, %eax
movl $1, %ebx
leal richiestaInput1, %ecx
movl richiestaInput1_len, %edx
int $0x80
# Lettura dell'input
movl $3, %eax
movl $1, %ebx
leal input1, %ecx
movl $10, %edx
int $0x80
# Inizio della conversione del primo numero da ASCII a decimale
leal input1, %esi
xorl %eax, %eax
xorl %ebx, %ebx
xorl %ecx, %ecx
xorl %edx, %edx
primoOp:
movb (%ecx,%esi,1), %bl
cmp $10, %bl
je finePrimoOp
subb $48, %bl
movl $10, %edx
mulb %dl 
addl %ebx, %eax
inc %ecx
jmp primoOp
finePrimoOp:
movl %eax,input1_int
movl %eax, %ebx
# Impostiamo eax a 1
movl $1, %eax

xorl %edx, %edx
inizioLoop:
cmpl $1, %ebx
je fine
# Moltiplichiamo il numero attuale contenuto in %ebx per %eax
mull %ebx
# Nel caso in cui venissero riempiti entrambi i registri, dai un messaggio di errore, siccome non si potrebbe fare un'altra moltiplicazione
cmpl $0, %edx
jne errore
dec %ebx
jmp inizioLoop
errore:
# In caso di errore stampalo a schermo
movl $4, %eax
movl $1, %ebx
leal erroreM, %ecx
movl erroreM_len, %edx
int $0x80
jmp return
fine:
# Trasformo da decimale ad ASCII
movl $10, %ebx
movl numero_len, %ecx
subl $2, %ecx
leal numero, %esi
inizioTrasformazione:
cmpl $0, %eax
jz stampa
xorl %edx, %edx
divl %ebx
addl $48, %edx
movb %dl, (%ecx, %esi)
decl %ecx
jmp inizioTrasformazione
stampa:
# Stampa a schermo dell'output
movl $4, %eax
movl $1, %ebx
leal risultatoM, %ecx
movl risultatoM_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
leal numero, %ecx
movl numero_len, %edx
int $0x80
return:
# Fine Programma
movl $1, %eax
xorl %ebx, %ebx
int $0x80

