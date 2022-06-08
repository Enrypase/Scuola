# Istruzioni base per allocare memoria in Assembly
# Sintassi AT&T - 80X86

movl $10, %ebx
pushl %ebx
call malloc
addl $4, %esp

xorl %ecx, %ecx
loop:
cmpl %ebx, %ecx
je endLoop
movb $48, (%eax, %ecx)
incl %ecx
jmp loop

endLoop:
pushl %eax
call free  
