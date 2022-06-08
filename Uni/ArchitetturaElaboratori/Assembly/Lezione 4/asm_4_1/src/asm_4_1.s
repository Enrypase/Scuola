.section .data
description: .ascii "Programma recupera e stampa parematri della riga di comando. Usando pop per estrarre parametri da stack\n"
description_len: .long . - description
printedParams: .long 0
nParams: .long 1
newLine: .byte 10
.section .text
.global _start

_start:
# Stampa a schermo del funzionamento del programma
movl $4, %eax
movl $1, %ebx
leal description, %ecx
movl description_len, %edx
int $0x80
                         
popl %ebx                           # Numero di parametri
subl $1, %ebx
movl %ebx, nParams

popl %eax                           # Togli dallo stack questo parametro - Inutile allo scopo del programma
printArgs:
movl printedParams, %eax
movl nParams, %ebx
cmpl %eax, %ebx
je fine                             # Se il numero dei parametri è uguale a quello dei parametri stampati
jz printArgs                        # Salta il primo parametro
# Stampa l'arg in questione
movl $4, %eax
movl $1, %ebx
popl %ecx
call str_len
int $0x80
# \n
movl $4, %eax
movl $1, %ebx
leal newLine, %ecx
movl $1, %edx
int $0x80

movl printedParams, %ebx
incl %ebx
movl %ebx, printedParams

jmp printArgs

fine:
movl $1, %eax
xorl %ebx, %ebx
int $0x80


# Funzione:
#
# -> ecx deve contenere la stringa di cui misurare la lunghezza
#
# -> edx contiene il valore di ritorno
#
.type str_len, @function
str_len:
# backup dei registri
pushl %eax
pushl %ebx
pushl %ecx

xorl %edx, %edx                         # Valore che verrà incrementato che indica la lunghezza della stringa
xorl %ebx, %ebx                         # Resettiamo, poi qui verrà salvato ogni byte

loop:
movb (%ecx, %edx), %bl

cmpb $0, %bl
je fineFunzione
incl %edx
jmp loop

fineFunzione:
# riscrivo i registri
popl %ecx
popl %ebx
popl %eax

ret
