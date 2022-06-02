.section .data
pilot_0_str: .ascii   "Pierre Gasly\0"
pilot_1_str: .ascii   "Charles Leclerc\0"
pilot_2_str: .ascii   "Max Verstappen\0"
pilot_3_str: .ascii   "Lando Norris\0"
pilot_4_str: .ascii   "Sebastian Vettel\0"
pilot_5_str: .ascii   "Daniel Ricciardo\0"
pilot_6_str: .ascii   "Lance Stroll\0"
pilot_7_str: .ascii   "Carlos Sainz\0"
pilot_8_str: .ascii   "Antonio Giovinazzi\0"
pilot_9_str: .ascii   "Kevin Magnussen\0"
pilot_10_str: .ascii  "Alexander Albon\0"
pilot_11_str: .ascii  "Nicholas Latifi\0"
pilot_12_str: .ascii  "Lewis Hamilton\0"
pilot_13_str: .ascii  "Romain Grosjean\0"
pilot_14_str: .ascii  "George Russell\0"
pilot_15_str: .ascii  "Sergio Perez\0"
pilot_16_str: .ascii  "Daniil Kvyat\0"
pilot_17_str: .ascii  "Kimi Raikkonen\0"
pilot_18_str: .ascii  "Esteban Ocon\0"
pilot_19_str: .ascii  "Valtteri Bottas\0"

// ? Le stringhe non sono salvate al contrario? No mi sembra

description: .ascii "\n\nTESTO_PROVVISORIO - Elaborato di Enrico Pasetto & Billibock Cristian\n\n\0"
description_len: .long . - description

current_word: .ascii "                    \0"
current_word_offset: .long 0

inputPilot: .ascii "                             \0"
# Pilot found in the entire file? 0 NO 1 YES
pilotFound: .byte 0
# Is the row we're analyzing of the specified pilot? 0 NO 1 YES
isRowPilot: .byte 0
# Save the ROW's time in this variable 
timeRead: .ascii "                     \0"
speedRead: .long 0
speedMax: .long 0 # ?
speedSum: .long 0 # ?
totalRows: .long 0 # ?
rpmRead: .long 0
rpmMax: .long 0 # ?
tempRead: .long 0
tempMax: .long 0 # ?

outputString: .ascii " \0" ????? OH NO, come facciamo?? https://stackoverflow.com/questions/30242596/malloc-in-assembly-8086 - In teoriah
outputString_offset: .long 0

invalid_pilot_str:	.ascii "Invalid\0"

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
pushl %eax
pushl %ecx
leal current_word, %ecx
movl current_word_offset, %eax
movb %dl, (%ecx, %eax)
incl %eax
movb $0, (%ecx, %eax)                               # ? il \0 non viene considerato | non incrementato abbastanza current_word_offset
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
// L'ultima colonna viene gestita con il \n
jmp telemetry_loop
firstColumn:
pushl %esi
pushl %edi
pushl %eax
pushl %ebx
pushl %ecx
xorl %ecx, %ecx
leal current_word, %esi
leal timeRead, %edi                         # ? Time è salvato malee
movl current_word_offset, %eax
firstColumnLoop:
cmpl %ecx, %eax
je firstColumnEnd 
movb (%esi, %ecx), %bl
movb %bl, (%edi, %ecx)
incl %ecx
movb $0, (%edi, %ecx)
jmp firstColumnLoop
firstColumnEnd:
popl %ecx
popl %ebx
popl %eax
popl %edi
popl %esi
jmp continue
secondColumn:
pushl %esi
pushl %edi
pushl %eax
pushl %ebx
leal current_word, %esi
call str2num
leal inputPilot, %esi
call is_input_pilot
movb $1, %al
cmpb %al, %ah
jne zeroFound
movb pilotFound, %bl
cmpb %al, %bl
je endSecondColumn
movb $1, isRowPilot
jmp endSecondColumn
zeroFound:
movl $0, isRowPilot
endSecondColumn:
popl %ebx
popl %eax
popl %edi
popl %esi
jmp continue
thirdColumn:
pushl %eax
movl isRowPilot, %eax
cmpl $0, %eax
popl %eax
je continue
pushl %esi
pushl %eax
leal current_word, %esi
call str2num
movl %eax, speedRead
popl %eax
popl %esi
jmp continue
forthColumn:
pushl %eax
movl isRowPilot, %eax
cmpl $0, %eax
popl %eax
je continue
pushl %esi
pushl %eax
leal current_word, %esi
call str2num
movl %eax, rpmRead
popl %eax
popl %esi
jmp continue
continue: 
incb %dh
pushl %eax
pushl %ebx
movl $0, current_word_offset
jmp telemetry_loop
telemetry_reset_column_count:
# If we read the pilot name save in its variable
cmpb $0, %dh
jne notFirstRow

# ? L'ultima colonna si raggiunge solo da qui! Fare delle funzioni per le colonne!!

# Copy the pilot name
pushl %ebx
pushl %ecx
pushl %edx
xorl %ecx, %ecx
movl current_word_offset, %ebx
leal current_word, %edi
copyPilotLoop:
cmpl %ecx, %ebx
je endPilotLoop
movb (%edi, %ecx), %al
leal inputPilot, %edx
movb %al, (%edx, %ecx)
incl %ecx
movb $0, (%edx, %ecx)
jmp copyPilotLoop
endPilotLoop:
popl %edx
popl %ecx
popl %ebx
movl $0, current_word_offset
jmp telemetry_loop
notFirstRow:
cmp $4, %dh
jne notLastColumn
fifthColumn:
pushl %eax
movl isRowPilot, %eax
cmpl $0, %eax
popl %eax
je notLastColumn
pushl %esi
pushl %eax
leal current_word, %esi
call str2num
movl %eax, tempRead
popl %eax
popl %esi
# Print outputs
analyzeVariables:
# <tempo> | <rpm> | <temperatura> | <speed>
# EAX     | EBX   | ECX           | EDX         ?? Registri sbaliati!! ??
# Output: ESI offsetOutput: EDI (? Super illegale!)
pushl %esi
pushl %edi
pushl %eax
pushl %ebx
pushl %ecx
pushl %edx

leal outputString, %esi
movl outputString_offset, %eax
leal timeRead, %ebx
xorl %ecx, %ecx
copyTimeLoop:
movb (%ebx, %ecx), %dl
cmpb $0, %dl
je endCopyTimeLoop
movb %dl, (%esi, %eax)
incl %eax
incl %ecx
jmp copyPilotLoop
endCopyTimeLoop:
movb $44, (%esi, %eax)
incl %eax
movl rpmRead, %ebx

pushl %eax
movl rpmMax, %eax
cmpl %eax, %ebx
jle writeRPM
movl %ebx, rpmMax
writeRPM:
popl %eax

cmpl $5000, %ebx
jl mediumOrHighRPM
# ?? Fare come funzione!
call appendLow
jmp calcTemp
mediumOrHighRPM:
cmpl $10000, %ebx
jl highRMP:
call appendMedium
jmp calcTemp
highRMP:
call appendHigh
calcTemp:
movb $44, (%esi, %eax)
incl %eax
movl tempRead, %ecx

movl tempMax, %ebx
cmpl %ebx, %ecx
jle writeTemp
movl %ecx, tempMax
writeTemp:
cmpl $90, %ecx
jl mediumOrHighTemp
call appendLow
jmp calcSpeed
mediumOrHighRPM:
cmpl $100, %ecx
jl highRPM
call appendMedium
jmp calcSpeed
highRPM:
call appendHigh
calcSpeed:
movb $44, (%esi, %eax)
incl %eax
movl speedRead, %edx

movl speedMax, %ecx
cmpl %ecx, %edx
jle writeSpeed
movl %edx, speedMax

writeSpeed:
movl speedSum, %ecx
addl %edx, %ecx
movl %ecx, speedSum

movl totalRows, %ecx
incl %ecx
movl %ecx, totalRows

cmpl $100, %edx
jl mediumOrHighSpeed:
call appendLow
jmp endAnalyze
mediumOrHighSpeed:
cmpl $250, %edx
jl highSpeed
call appendMedium
jmp endAnalyze
highSpeed:
call appendHigh
endAnalyze:

movl %eax, offsetOutput

popl %edx
popl %ebx
popl %ebx
popl %eax
popl %edi
popl %esi
notLastColumn:
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
# ????? Stampa riepilogo totale
# RPM

# TEMP

# SPEED MAX

# SPEED AVG

# ?? AAaahh serve la funzione int2str

leal output, %eax
ret
telemetry_end:
popl %edx
popl %ecx
popl %ebx

ret


# Input: ESI pilot name
# Input: EAX/AL pilot id
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

movl %eax, %ecx

leal pilot_0_str, %eax
pushl %eax
leal pilot_1_str, %eax
pushl %eax
leal pilot_2_str, %eax
pushl %eax
leal pilot_3_str, %eax
pushl %eax
leal pilot_4_str, %eax
pushl %eax
leal pilot_5_str, %eax
pushl %eax
leal pilot_6_str, %eax
pushl %eax
leal pilot_7_str, %eax
pushl %eax
leal pilot_8_str, %eax
pushl %eax
leal pilot_9_str, %eax
pushl %eax
leal pilot_10_str, %eax
pushl %eax
leal pilot_11_str, %eax
pushl %eax
leal pilot_12_str, %eax
pushl %eax
leal pilot_13_str, %eax
pushl %eax
leal pilot_14_str, %eax
pushl %eax
leal pilot_15_str, %eax
pushl %eax
leal pilot_16_str, %eax
pushl %eax
leal pilot_17_str, %eax
pushl %eax
leal pilot_18_str, %eax
pushl %eax
leal pilot_19_str, %eax
pushl %eax


# Calculating where to take the data in stack
movb $19, %al
subb %cl, %al
pushl %ebx
xorl %ebx, %ebx
movb $4, %bl
mulb %bl
popl %ebx
movw %ax, %dx 


addl %edx, %esp
# Now whe have the pilot in EDX
popl %edi

# Reset the ESP to the origin
movb %cl, %al
pushl %ebx
xorl %ebx, %ebx
movb $4, %bl
mulb %bl
popl %ebx
xorl %edx, %edx
movw %ax, %dx
addl %edx, %esp

# Now let's check the pilot
leal inputPilot, %esi               # Input from file

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
pushl %edx
xorl %eax, %eax
call str_leng
pushl %esi
movl %edi, %esi                 # Richiamo della funzione su EDI
movl %ebx, %ecx                 # Primo valore di lunghezza contenuto in ECX
call str_leng                   # Secondo valore di lunghezza contenuto in EBX
popl %esi                       # Ripristiniamo il valore corretto a ESI
cmpl %ecx, %ebx
jne str_not_equal               # Nel caso una stringa sia maggiore dell'altra, sicuramente non sono uguali
xorl %ecx, %ecx                 # Reset del contenuto di ECX, sarà usato come contatore
call str_leng
xorl %edx, %edx
str_equals_loop:
movb (%esi, %ecx), %al          # Il byte letto da ESI è contenuto in AL
cmpb (%edi, %ecx), %al          # Comparazione tra byte di EDI e corrispondente di ESI
jne str_not_equal               # Nel caso in cui i due byte non fossero uguali esci
cmpl %ebx, %edx                 # Controllo se il byte letto è \0. Basta una lettura, dato che le due stringhe hanno uguale lunghezza
je str_equal                    # A questo punto, le due stringhe sono sicuramente uguali, altrimenti il programma sarebbe uscito prima
incl %edx
jmp str_equals_loop             # Altrimenti continua a controllare i prossimi    
str_equal:
movb $1, %ah
jmp str_equals_end
str_not_equal:
xorb %ah, %ah
str_equals_end:
popl %edx
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

# Input: ESI -> Stringa da convertire
# Output: EAX
.type str2num, @function
str2num:
pushl %ebx
pushl %ecx
pushl %edx

xorl %eax, %eax
xorl %ebx, %ebx            # azzero il registro EBX
xorl %ecx, %ecx            # azzero il contatore
ripeti:

pushl %edx
movl current_word_offset, %edx
cmp %ecx, %edx
popl %edx
je fine

movb (%ecx,%esi,1), %bl
subb $48, %bl             # converte il codice ASCII della cifra nel numero corrisp.
movl $10, %edx
mull %edx                  # EBX = EBX * 10
addl %ebx, %eax
inc %ecx
jmp ripeti


fine:

popl %edx
popl %ecx
popl %ebx

ret

# Input: ESI
# Output: ESI
# outputOffsed modified (%EAX)
.type appendLow, @function
appendLow:
movb $76, (%esi, %eax)
incl %eax
movb $79, (%esi, %eax)
incl %eax
movb $87, (%esi, %eax)
incl %eax
ret

# Input: ESI
# Output: ESI
# outputOffsed modified (%EAX)
.type appendMedium, @function
appendMedium:
movb $77, (%esi, %eax)
incl %eax
movb $69, (%esi, %eax)
incl %eax
movb $88, (%esi, %eax)
incl %eax
movb $73, (%esi, %eax)
incl %eax
movb $85, (%esi, %eax)
incl %eax
movb $77, (%esi, %eax)
incl %eax
ret

# Input: ESI
# Output: ESI
# outputOffsed modified (%EAX)
.type appendHigh, @function
appendHigh:
movb $72, (%esi, %eax)
incl %eax
movb $73, (%esi, %eax)
incl %eax
movb $71, (%esi, %eax)
incl %eax
movb $72, (%esi, %eax)
incl %eax
ret
