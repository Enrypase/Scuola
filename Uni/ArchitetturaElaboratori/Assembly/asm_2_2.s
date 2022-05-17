.section .data
testo:
.ascii "\nScrivere un programma Assembly che confronti 2 numeri caricati nei registri EAX, EBX e stampi una stringa che indichi quale sia il maggiore e il minore, oppure indichi che i due numeri sono uguali\n\n"
testo_len:
.long . - testo

minore:
.ascii "Il secondo numero è maggiore del primo\n"
minore_len:
.long . - minore

maggiore:
.ascii "Il primo numero è maggiore del secondo\n"
maggiore_len:
.long . - maggiore

uguale:
.ascii "I due numeri sono uguali\n"
uguale_len:
.long . - uguale

.section .text
.global _start

_start:
movl $20, %eax
movl $10, %ebx

cmpl %ebx, %eax
jg greater
je equals
movl $4, %eax
movl $1, %ebx
leal minore, %ecx
movl minore_len, %edx
int $0x80
jmp continue
greater: 
movl $4, %eax
movl $1, %ebx
leal maggiore, %ecx
movl maggiore_len, %edx
int $0x80
jmp continue
equals:
movl $4, %eax
movl $1, %ebx
leal uguale, %ecx
movl uguale_len, %edx
int $0x80
continue:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
