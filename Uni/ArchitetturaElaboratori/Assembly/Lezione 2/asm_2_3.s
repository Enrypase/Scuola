# Non va, mi dice "Floating point exception"
.section .data
text:
.ascii "This programs converts every number given to ascii! Max 32 bit number\n\n"
text_len:
.long . - text

number:
.long 100

number_ascii:
.ascii "max_string"

.section .text
.global _start

_start:
leal number_ascii, %esi
movl number, %eax
movl $10, %ecx

start_loop:
cmpl $0, %eax
jz end
divl %ecx
addl $48, %edx
movb %dl, (%esi)
jmp start_loop


end:
movl $4, %eax
movl $1, %ebx
leal text, %ecx
movl text_len, %edx
int $0x80

movl $4, %eax
movl $1, %ebx
leal number_ascii, %ecx
movl $10, %edx
int $0x80

movl $1, %eax
xorl %ebx, %ebx
int $0x80


