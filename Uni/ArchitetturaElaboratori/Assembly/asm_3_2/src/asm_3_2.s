.section .data
testo: .ascii "Aggiungere input da tastiera rispetto ad asm_3_1.\n\n"
testo_len: .long . - testo
richiesta1: .ascii "Inserire il primo numero: "
richiesta1_len: .long . - richiesta1
input1: .ascii "000\n"
input1_int: .long 0
richiesta2: .ascii "Inserire il secondo numero: "
richiesta2_len: .long . - richiesta2
input2: .ascii "000\n"
input2_int: .long 0
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
# Prima richiesta
movl $4, %eax
movl $1, %ebx
leal richiesta1, %ecx
movl richiesta1_len, %edx
int $0x80
# Prima lettura dell'input:
movl $3, %eax
movl $1, %ebx
leal input1, %ecx
movl $4, %edx
int $0x80
# Seconda richiesta
movl $4, %eax
movl $1, %ebx
leal richiesta2, %ecx
movl richiesta2_len, %edx
int $0x80
# Seconda lettura dell'input
movl $3, %eax
movl $1, %ebx
leal input2, %ecx
movl $4, %edx
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

# Inizio della conversione del secondo numero da ASCII a decimale
leal input2, %esi
xorl %eax,%eax
xorl %ebx,%ebx           
xorl %ecx,%ecx           
xorl %edx,%edx
secondoOp:
movb (%ecx,%esi,1), %bl
cmp $10, %bl
je fineSecondoOp
subb $48, %bl
movl $10, %edx
mulb %dl
addl %ebx, %eax
inc %ecx
jmp secondoOp
fineSecondoOp:	
# Da variabili a registri
movl %eax,%ebx
movl input1_int, %eax
# Inizio traduzione dell'algoritmo da C ad Assembly
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

