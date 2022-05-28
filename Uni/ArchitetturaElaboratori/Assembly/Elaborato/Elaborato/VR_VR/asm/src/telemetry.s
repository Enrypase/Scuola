.section .data
pilot_0_str:
    .string   "Pierre Gasly\0"
pilot_1_str:
    .string   "Charles Leclerc\0"
pilot_2_str:
    .string   "Max Verstappen\0"
pilot_3_str:                       
    .string   "Lando Norris\0"
pilot_4_str:
    .string   "Sebastian Vettel\0"
pilot_5_str:
    .string   "Daniel Ricciardo\0"
pilot_6_str: 
    .string   "Lance Stroll\0"
pilot_7_str:
    .string   "Carlos Sainz\0"
pilot_8_str:
    .string   "Antonio Giovinazzi\0"
pilot_9_str:
    .string   "Kevin Magnussen\0"
pilot_10_str:
    .string  "Alexander Albon\0"
pilot_11_str:
    .string  "Nicholas Latifi\0"
pilot_12_str:
    .string  "Lewis Hamilton\0"
pilot_13_str:
    .string  "Romain Grosjean\0"
pilot_14_str:
    .string  "George Russell\0"
pilot_15_str:
    .string  "Sergio Perez\0"
pilot_16_str:
    .string  "Daniil Kvyat\0"
pilot_17_str:
    .string  "Kimi Raikkonen\0"
pilot_18_str:
    .string  "Esteban Ocon\0"
pilot_19_str:
    .string  "Valtteri Bottas\0"

description: .ascii "\n\nTESTO_PROVVISORIO - Elaborato di Enrico Pasetto & Billibock Cristian\n\n\0"
description_len: .long . - description

current_word: .ascii "                    \0"
current_word_offset: .long 0

inputPilot: .ascii "                             \0"
# Pilot found in the entire file? 0 NO 1 YES
pilotFound: .short 0
# Is the row we're analyzing of the specified pilot? 0 NO 1 YES
isRowPilot: .short 0


invalid_pilot_str:	
.string "Invalid\0"

.section .text
.global telemetry

# EAX output
# EBX offset input
# ECX offset output
# DH salva offset colonna
# DL salva carattere letto attualmente

# ESI stringa in input
# EDI ?
telemetry:
pushl %ebx
pushl %ecx
pushl %edx

xorl %eax, %eax
xorl %ebx, %ebx
xorl %ecx, %ecx
xorl %edx, %edx

movl 16(%esp), %esi
         
telemetry_loop:
movb (%esi, %ebx), %dl
incl %ebx
cmpb $0, %dl
je telemetry_print_last_row
cmpb $10, %dl
je telemetry_reset_column_count
cmpb $44, %dl
je telemetry_comma_encountered
pushl %ebx
pushl %ecx
leal current_word, %ecx
movl current_word_offset, %eax
movb %al, (%ecx, %eax)
incl %eax
movl %eax, current_word_offset
popl %ecx
popl %eax
jmp telemetry_loop
telemetry_comma_encountered:
# Analizza colonna
cmpb $0, %dh
je firstColumn
cmpb $1, %dh
je secondColumn
cmpb $2, %dh
je thirdColumn
cmpb $3, %dh
je forthColumn
firstColumn:
#   METTI IN STACK
#
jmp continue
secondColumn:
#   CONTROLLA SE IL PILOTA è UGUALE. SE SI IMPOSTA VARIABILI
#   SE NO RIMUOVI DA STACK E SKIPPA
jmp continue
thirdColumn:
#   SE PILOTA UGUALE ANALIZZA ALTRIMENTI SKIPPA
#
jmp continue
forthColumn:
#   SE PILOTA UGUALE ANALIZZA ALTRIMENTI SKIPPA
#
continue: 
incb %dh
pushl %eax
pushl %ebx
leal current_word, %eax
movl current_word_offset, %ebx
movb $0, (%eax, %ebx, 1)
popl %ebx
popl %eax
movl $0, current_word_offset
jmp telemetry_loop
telemetry_reset_column_count:
# If we read the pilot name save in its variable
cmpb $0, %dh
jne notFirstRow
# Copy the pilot name
pushl %eax
pushl %ebx
pushl %ecx
xorl %ecx, %ecx
movl current_word_offset, %ebx
movl current_word, %eax
copyPilotLoop:
cmpl %ecx, %ebx
je endPilotLoop
movb (%eax, %ecx), inputPilot
incl %ecx
jmp copyPilotLoop
endPilotLoop:
popl %eax
popl %ebx
popl %ecx
notFirstRow:
xorb %dh, %dh
pushl %eax
pushl %ebx
movl current_word_offset, %ebx
leal current_word, %eax
movb $0, (%eax, %ebx, 1)
popl %ebx
popl %eax
movl $0, current_word_offset
jmp telemetry_loop
telemetry_print_last_row:
# Stampa riepilogo totale
#
#
telemetry_end:
popl %edx
popl %ecx
popl %ebx

ret


# Input: ESI pilot name
# Input: AH pilot id
# Output: AH true 1 false 0
.type is_input_pilot, @function
is_input_pilot:

# Pilot from stack
pushl %ebx
# ECX: ESI offset
pushl %ecx
# Arithmetic operations
pushl %edx

xorl %ebx, %ebx
xorl %edx, %edx

movb %ah, %ch

pushl pilot_0_str
pushl pilot_1_str
pushl pilot_2_str
pushl pilot_3_str
pushl pilot_4_str
pushl pilot_5_str
pushl pilot_6_str
pushl pilot_7_str
pushl pilot_8_str
pushl pilot_9_str
pushl pilot_10_str
pushl pilot_11_str
pushl pilot_12_str
pushl pilot_13_str
pushl pilot_14_str
pushl pilot_15_str
pushl pilot_16_str
pushl pilot_17_str
pushl pilot_18_str
pushl pilot_19_str
# Calculating where to take the data in stack
movb $20, %al
addb %ah, %al
mulb $4
movw %ax, %dx 


subl %edx, %esp
# Now whe have the pilot in EDX
popl %ebx

# Reset the ESP to the origin
movb %ch, %al
mulb $4
xorl %edx, %edx
movw %ax, %dx
addb %edx, %esp

# Now let's check the pilot
movl %ebx, %edi
call str_equals
end_is_input_pilot:
popl %edx
popl %ecx
popl %ebx

ret

# Input: ESI str1
# Input: EDI str2
# Output: AH
.type str_equals, @function     # Funzione che ritorna in output 0 se le due stringhe sono differenti, altrimenti 1
str_equals:
pushl %ebx
pushl %ecx
xorl %eax, %eax
call str_leng
int $0x80
pushl %esi
movl %edi, %esi                 # Richiamo della funzione su EDI
movl %ebx, %ecx                 # Primo valore di lunghezza contenuto in ECX
call str_leng                   # Secondo valore di lunghezza contenuto in EBX
int $0x80
popl %esi                       # Ripristiniamo il valore corretto a ESI
cmpl %ecx, %ebx
jne str_not_equal               # Nel caso una stringa sia maggiore dell'altra, sicuramente non sono uguali
xorl %ecx, %ecx                 # Reset del contenuto di ECX, sarà usato come contatore
str_equals_loop:
movb (%esi, %ecx), %al          # Il byte letto da ESI è contenuto in AL
cmpb $0, %al                    # Controllo se il byte letto è \0. Basta una lettura, dato che le due stringhe hanno uguale lunghezza
je str_equal                    # A questo punto, le due stringhe sono sicuramente uguali, altrimenti il programma sarebbe uscito prima
cmpb (%edi, %ecx), %al          # Comparazione tra byte di EDI e corrispondente di ESI
jne str_not_equal               # Nel caso in cui i due byte non fossero uguali esci
jmp str_equals_loop             # Altrimenti continua a controllare i prossimi    
str_equal:
movb $1, %ah
jmp str_equals_end
str_not_equal:
xorb %ah, %ah
str_equals_end:
popl %ecx
popl %ebx
ret

# Input: ESI
# Output: EBX
.type str_leng, @function       # Funzione che calcola la lunghezza di una stringa
str_leng:
pushl %eax                      # EAX sarà usato per salvare i byte
xorl %ebx, %ebx                 # EBX conterrà il valore di ritorno
str_leng_loop:
movb (%esi, %ebx), %al          # Muovi il byte in AL
incl %ebx                       # Incrementa la lunghezza della stringa
cmpb $0, %al                    # Se il carattere letto è \0
je str_leng_end                 # Fine programma
jmp str_leng_loop               # Altrimenti continua con la lettura/calcolo
str_leng_end:
popl %eax                       # Ripristino dell'unico registro general purpose utilizzato (eccetto EBX)

ret                             # Ritorno
