### 30/06/2022 - Università Degli Studi Di Verona
### Elaborato ASM
### Autori: Enrico Pasetto & Cristian - Francisc Biliboc

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
# Altre variabili - Descritte nella relazione
tempString: .ascii "          \0"
invalidString: .ascii "Invalid\n\0"
currentWord: .ascii "                      \0"
rowId: .short 0
inputPilotNumber: .short -1
timeRead: .ascii "                     \0"
speedRead: .long 0
speedMax: .long 0
speedSum: .long 0
totalRows: .long 0
rpmRead: .long 0
rpmMax: .long 0
tempRead: .long 0
tempMax: .long 0
outputString: .long 0
outputStringOffset: .long 0

.section .text
.global telemetry
telemetry:
# Operazioni preliminari
pushl %ebx
pushl %ecx
pushl %edx
movl 20(%esp), %eax                             # Salva l'indirizzo della stringa in output in eax
movl %eax, outputString                         # E salvalo nella variabile outputString
movl 16(%esp), %esi                             # Salva l'indirizzo della stringa riguardante il file in input in
leal currentWord, %edi
xorl %eax, %eax
xorl %ebx, %ebx
xorb %dh, %dh

# Inizia il loop principale         
telemetry_loop:
movb (%esi, %ebx), %dl                          # Leggi il byte corrente dalla stringa in input
incl %ebx                                       # Incrementa l'offset della stringa in input
cmpb $0, %dl                                    # Se il carattere letto è \0
je telemetry_print_last_row                         # Salta alla funzione di fine file
cmpb $10, %dl                                   # Se il carattere letto è \n
je telemetry_reset_column_count                     # Salta alla funzione che gestisce \n
cmpb $44, %dl                                   # Se il carattere letto è ,
je telemetry_comma_encountered                      # Salta alla funzione che gestisce la ,
# Altrimenti, se stiamo attualmente leggendo un carattere che fa parte di una colonna:
movb %dl, (%edi, %eax)                          # Concatena il byte letto alla parola corrente
incl %eax                                       # Incrementa l'offset
movb $0, (%edi, %eax)                           # Aggiungi il carattere finale \0, verrà sovrascritto se la parola ha un altro carattere
jmp telemetry_loop                              # Salta all'inizio del loop principale

# Codice che gestisce il carattere della virgola
telemetry_comma_encountered:
cmpb $0, %dh                                    # Se si tratta della prima colonna <tempo>
je firstColumn                                      # Salta alla funzione che la gestisce
cmpb $1, %dh                                    # Se si tratta della seconda colonna <id_pilota>
je secondColumn                                     # Salta alla funzione che la gestisce
cmpb $2, %dh                                    # Se si tratta della terza colonna <velocità>
je thirdColumn                                      # Salta alla funzione che la gestisce
cmpb $3, %dh                                    # Se si tratta della quarta colonna <rpm>
je forthColumn                                      # Salta alla funzione che la gestisce
jmp telemetry_loop                              # Salta all'inizio del loop principale

# Codice che gestisce la prima colonna <tempo>
firstColumn:
pushl %esi
xorl %ecx, %ecx                                 # Resetta il registro ecx
leal timeRead, %esi                             # Carica il tempo letto in edi

# Fai copia/incolla della stringa da currentWord in timeRead
firstColumnLoop:
cmpl %ecx, %eax
je firstColumnEnd 
movb (%edi, %ecx), %dl
movb %dl, (%esi, %ecx)
incl %ecx
movb $0, (%esi, %ecx)
jmp firstColumnLoop
firstColumnEnd:
popl %esi
jmp continue

# Codice che gestisce la seconda colonna <pilot_id>
secondColumn:
call str2num                                    # Chiama la funzione che la traduca in numero
movb %cl, rowId
jmp continue

# Codice che gestisce la quarta colonna <velocità>
thirdColumn:
movb inputPilotNumber, %ch
movb rowId, %cl
cmpb %ch, %cl
jne continue                                    # Salta l'interpretazione (scrittura) della riga corrente
call str2num                                    # Converti la velocità letta da stringa in numero
movl %ecx, speedRead                            # Una volta convertiti, sposta il risultato in speedRead
jmp continue

# Codice che gestisce la quarta colonna <rpm>
forthColumn:
movb inputPilotNumber, %ch
movb rowId, %cl
cmpb %ch, %cl
jne continue                                    # Salta l'interpretazione (scrittura) della riga corrente
call str2num                                    # Converti gli rpm letti da stringa in numero
movl %ecx, rpmRead                              # Una volta convertiti, sposta il risultato in rpmRead
continue: 
incb %dh                                        # Incrementa la colonna netta
xorl %eax, %eax
jmp telemetry_loop                              # Salta al loop principale

# Codice che gestisce il \n
telemetry_reset_column_count:
cmpb $0, %dh                                    # Controlla se si ha letto la prima riga del file di input (colonna quando si incontra il \n = 0) 
jne notFirstRow                                 # Salta la logica che gestirebbe una riga comune
pushl %esi
movl %edi, %esi
call is_input_pilot
popl %esi
movb inputPilotNumber, %cl
cmpb $-1, %cl
je telemetry_print_last_row
jmp telemetry_loop                              # Salta al loop principale

notFirstRow:                                    # Nel caso in cui si trattasse di una riga che non sia la prima:                                  
movb inputPilotNumber, %ch
movb rowId, %cl
cmpb %ch, %cl
jne notLastColumn                               # Se non lo fosse, salta questo passaggio       
call str2num                                    # Convertilo in numero
movl %ecx, tempRead                             # Muovi il risultato in tempRead

# Analizza/scrivi in output i valori della riga corrente
analyzeVariables:
pushl %esi
pushl %edi
pushl %eax
pushl %ebx
pushl %edx
movl outputString, %esi                         # Muovi l'indirizzo della stringa in output in esi
movl outputStringOffset, %eax                   # Muovi il suo offset in eax

leal timeRead, %ebx                             # Muovi l'indirizzo della strigna timeRead in ebx
xorl %ecx, %ecx                                 # Resetta il registro counter
# Copia il tempo della riga letta in output
copyTimeLoop:
movb (%ebx, %ecx), %dl
cmpb $0, %dl
je endCopyTimeLoop
movb %dl, (%esi, %eax)
incl %eax                                       # Incrementa sia il counter per l'offset della stringa in output
incl %ecx                                       # Sia quello della lettura della parola corrente
jmp copyTimeLoop
endCopyTimeLoop:
movb $44, (%esi, %eax)                          # Aggiungi una ,
incl %eax                                       # Incrementa l'offset della stringa in output di uno

movl rpmRead, %ebx                              # Muovi gli rpm letti nell'ultima riga in ebx
movl rpmMax, %edx                               # Muovi il numero massimo di rpm in eax
cmpl %edx, %ebx                                 # Se il numero appena letto è maggiore degli rpm massimi
jle writeRPM
movl %ebx, rpmMax                               # Sovrascrivi il contenuto di rmpMax con quest'ultimo
writeRPM:
cmpl $5000, %ebx                                # Compara gli rpm letti con 5000 (soglia low)
jg mediumOrHighRPM                              # Se sono maggiori controlla se siano medium/high
call appendLow                                  # Nel caso in cui siano inferiori, concatena alla stringa in output LOW
jmp calcTemp                                    # E prosegui calcolando la temperatura
mediumOrHighRPM:
cmpl $10000, %ebx                               # Compara gli rpm letti con 10000 (soglia medium)
jg highRMP                                      # Se sono maggiori, allora sicuramente sono high
call appendMedium                               # Altrimenti, concatena la stringa medium
jmp calcTemp                                    # E prosegui calcolando la temperatura
highRMP:
call appendHigh                                 # Nel caso in cui siano al di sopra della soglia high, concatena quest'ultima alla stringa in output
calcTemp:
movb $44, (%esi, %eax)                          # Inserisci una virgola dopo il risultato concatenato per gli rpm
incl %eax                                       # Incrementa il contatore della stringa in output

movl tempRead, %ecx                             # Muovi la temperatura letta nell'ultima stringa in ecx
movl tempMax, %ebx                              # Muovi la temperatura massima in ebx
cmpl %ebx, %ecx                                 # Compara questi due
jle writeTemp                                   # Se la temperatura letta è minore di quella massima (attuale) salta 
movl %ecx, tempMax                              # Altrimenti sovrascrivila
writeTemp:
cmpl $90, %ecx                                  # Compara la temperatura letta nell'ultima riga con 90 (soglia low)
jg mediumOrHighTemp                             # Se dovesse essere maggiore controlla se sia medium or high
call appendLow                                  # Altrimenti concatena alla stringa in output low
jmp calcSpeed                                   # E prosegui calcolando la velocità
mediumOrHighTemp:
cmpl $100, %ecx                                 # Compara la temperatura letta nell'ultima riga con 100 (soglia medium)
jg highTemp                                     # Se dovesse essere maggiore, significa che la temperatura è high
call appendMedium                               # Altrimenti concatena alla stringa in output medium
jmp calcSpeed                                   # E prosegui calcolando la velocità
highTemp:
call appendHigh                                 # Se la temperatura fosse sopra la soglia high, concatena high alla stringa finale
calcSpeed:
movb $44, (%esi, %eax)                          # Concatena una virgola in seguito all'inserimento del valore della temperatura
incl %eax                                       # E incrementa l'offset della stringa in output

movl speedRead, %edx                            # Sposta la velocità letta in edx
movl speedMax, %ecx                             # Sposta l'attuale velocità massima in ecx
cmpl %ecx, %edx                                 # Comparale
jle writeSpeed                                  # Se la velocità attualmente letta fosse inferiore salta 
movl %edx, speedMax                             # Altrimenti sovrascrivi la velocità massima con quella corrente
writeSpeed:
movl speedSum, %ecx                             # Muovi la somma delle velocità in ecx
addl %edx, %ecx                                 # E aggiungile la velocità appena letta
movl %ecx, speedSum                             # A questo punto, sovrascrivi il valore della somma con quello aggiornato
movl totalRows, %ecx                            # Muovi le righe totali in ecx
incl %ecx                                       # Incrementale di uno
movl %ecx, totalRows                            # E salvane il valore
cmpl $100, %edx                                 # Compara la velocità attuale con 100 (soglia low)
jg mediumOrHighSpeed                            # Se fosse maggiore, controlla che sia medium o high
call appendLow                                  # Altrimenti concatena alla stringa in output low
jmp endAnalyze                                  # E finisci l'analisi della riga in input
mediumOrHighSpeed:
cmpl $250, %edx                                 # Compara la velocità letta con 250 (soglia medium)
jg highSpeed                                    # Se fosse maggiore, significherebbe che la velocità sia high
call appendMedium                               # Altrimenti concatena medium alla stringa in output
jmp endAnalyze                                  # E finisci l'analisi della riga in input
highSpeed:
call appendHigh                                 # Se la velocità fosse al di sopra della soglia high, concatena high alla stringa in output
endAnalyze:
movb $10, (%esi, %eax)                          # A questo punto concatena \n alla stringa in output
incl %eax                                       # E incrementa l'offset di quest'ultima
movl %eax, outputStringOffset                  # Sovrascrivi l'offset della stringa in output con il valore aggiornato
popl %edx
popl %ebx
popl %eax
popl %edi
popl %esi
notLastColumn:                                  # Nel caso in cui ci fosse un \n ma non si trattasse dell'ultima colonna
xorb %dh, %dh                                   # Resetta il numero di colonna
xorl %eax, %eax
jmp telemetry_loop                              # E salta al loop principale

# Stampa le statistiche (ultima riga di output)
telemetry_print_last_row:
movl outputString, %edi                         # Muovi l'indirizzo della stringa di output in edi
movl outputStringOffset, %ecx                  # E muovi il relativo offset in ecx
movl totalRows, %eax                            # Muovi le righe totali in eax
cmpl $0, %eax                                   # E comparale con zero
jne notInvalid                                  # Se sono diverse (maggiori) di zero, significa che il pilota inserito è corretto
leal invalidString, %esi                        # Altrimenti

# Stampa "Invalid\0" in output
invalidLoop:
movb (%esi, %ecx), %dl
cmpb $0, %dl
je invalidEnd
movb %dl, (%edi, %ecx)
incl %ecx
jmp invalidLoop
invalidEnd:
jmp endAvgSpeedLoop                             # E salta alla fine

notInvalid:
movl rpmMax, %eax                               # Muovi gli rpm massimi in eax
call num2str                                    # Convertili in stringa
xorl %edx, %edx                                 # Resetta edx
# E concatena la stringa ottenuta alla stringa in output
rpmLoop:
movb (%esi,%edx), %bl
cmpb $0, %bl
je endRpmLoop
movb %bl, (%edi,%ecx)
incl %ecx
incl %edx
jmp rpmLoop
endRpmLoop:
movb $44, (%edi, %ecx)                          # Una volta finito, concatena una virgola alla stringa in output
incl %ecx                                       # E incrementane il relativo offset

movl tempMax, %eax                              # Muovi la temperatura massima in eax
call num2str                                    # Convertila in stringa
xorl %edx, %edx                                 # Resetta edx
# E concatena la stringa ottenuta alla stringa in output
tempLoop:
movb (%esi,%edx), %bl
cmpb $0, %bl
je endTempLoop
movb %bl, (%edi,%ecx)
incl %ecx
incl %edx
jmp tempLoop
endTempLoop:
movb $44, (%edi, %ecx)                          # Una volta finito, concatena una virgola alla stringa in output
incl %ecx                                       # E incrementane il relativo offset

movl speedMax, %eax                             # Muovi la velocità massima in eax
call num2str                                    # Convertila in stringa
xorl %edx, %edx                                 # Resetta edx
# E concatena la stringa ottenuta alla stringa in output
maxSpeedLoop:
movb (%esi,%edx), %bl
cmpb $0, %bl
je endMaxSpeedLoop
movb %bl, (%edi,%ecx)
incl %ecx
incl %edx
jmp maxSpeedLoop
endMaxSpeedLoop:
movb $44, (%edi, %ecx)                          # Una volta finito, concatena una virgola alla stringa in output
incl %ecx                                       # E incrementane il relativo offset

movl speedSum, %eax                             # Muovi la somma delle velocità in eax
movl totalRows, %ebx                            # Muovi le righe lette totali in ebx
xorl %edx, %edx                                 # Resetta edx
divl %ebx                                       # Dividi la somma delle velocità con il numero di righe lette (per ottenere la media delle velocità)
call num2str                                    # Convertila in stringa
xorl %edx, %edx
# E concatena la stringa ottenuta alla stringa in output
avgSpeedLoop:
movb (%esi,%edx), %bl
cmpb $0, %bl
je endAvgSpeedLoop
movb %bl, (%edi,%ecx)
incl %ecx
incl %edx
jmp avgSpeedLoop
# Fine della scrittura dell'ultima stringa
endAvgSpeedLoop:
movb $10, (%edi,%ecx)
popl %edx
popl %ecx
popl %ebx
ret

# Descrizione: La seguente funzione permette di sapere, dato il nome di un pilota e l'id se i due coincidono
# Input: ESI pilot name (preso dalla memoria)
# Input: EAX/AL pilot id
# Output: metti in inputPilotNumber se pilota trovato
.type is_input_pilot, @function
is_input_pilot:
pushl %esi
pushl %edi
pushl %eax
pushl %ebx
pushl %edx
xorl %ebx, %ebx                                 # Resetta ebx
xorl %ecx, %ecx                                 # Resetta edx
# Ora, carica gli indirizzi dei nomi dei diciannove piloti nello stack
leal pilot_19_str, %eax
pushl %eax
leal pilot_18_str, %eax
pushl %eax
leal pilot_17_str, %eax
pushl %eax
leal pilot_16_str, %eax
pushl %eax
leal pilot_15_str, %eax
pushl %eax
leal pilot_14_str, %eax
pushl %eax
leal pilot_13_str, %eax
pushl %eax
leal pilot_12_str, %eax
pushl %eax
leal pilot_11_str, %eax
pushl %eax
leal pilot_10_str, %eax
pushl %eax
leal pilot_9_str, %eax
pushl %eax
leal pilot_8_str, %eax
pushl %eax
leal pilot_7_str, %eax
pushl %eax
leal pilot_6_str, %eax
pushl %eax
leal pilot_5_str, %eax
pushl %eax
leal pilot_4_str, %eax
pushl %eax
leal pilot_3_str, %eax
pushl %eax
leal pilot_2_str, %eax
pushl %eax
leal pilot_1_str, %eax
pushl %eax
leal pilot_0_str, %eax
pushl %eax
movl $20, %ebx
# Trova l'id del pilota e salvalo in "inputPilotNumber"
loopIsInputPilot:
cmpl %ebx, %ecx
jge endIsInputPilot
popl %esi
call str_equals
cmpb $1, %ah
jne continueIsInputPilot
movb %cl, inputPilotNumber
continueIsInputPilot:
incl %ecx
jmp loopIsInputPilot
endIsInputPilot:
popl %edx
popl %ebx
popl %eax
popl %edi
popl %esi
ret

# Descrizione: Date due stringhe, ci permette di capire se sono uguali oppure no
# Input: ESI str1, EDI str2
# Output: AH
.type str_equals, @function
str_equals:
pushl %ebx
pushl %ecx
xorl %ecx, %ecx                 # Reset del contenuto di ecx, sarà usato come contatore
xorl %edx, %edx                 # Reset di edx
movb $1, %ah                    # Metti il valore 1 (stringhe uguali) in ah, se poi saranno diverse questo verrà sovrascritto
# Controlliamo che tutti i byte coincidano
str_equals_loop:
movb (%esi, %ecx), %al
cmpb (%edi, %ecx), %al
jne str_not_equal
cmpb $0, (%edi, %ecx)
je str_equals_end
incl %ecx
jmp str_equals_loop
str_not_equal:
mov $0, %ah
str_equals_end:
popl %ecx
popl %ebx
ret

# Descrizione: converte una stringa data nel relativo valore numerico
# Input: EDI -> Stringa da convertire
# Output: ECX
.type str2num, @function
str2num:
pushl %esi
pushl %eax
pushl %ebx
pushl %edx
movl %eax, %ecx
xorl %esi, %esi                 # Utilizzato per mancanza di registri general purpose
xorl %eax, %eax      
xorl %ebx, %ebx           
ripeti:
cmpl %esi, %ecx
je fineStr2Num
movb (%edi,%esi,1), %bl
subb $48, %bl                   # converte il codice ASCII della cifra nel numero corrisp.
movl $10, %edx
mull %edx                       # ECX = ECX * 10
addl %ebx, %eax
inc %esi
jmp ripeti
fineStr2Num:
movl %eax, %ecx
popl %edx
popl %ebx
popl %eax
popl %esi
ret

# Descrizione: Funzione inversa alla precedente
# Input: EAX
# Output: ESI
.type num2str, @function
num2str:
pushl %edi
pushl %eax
pushl %ebx
pushl %ecx
pushl %edx
leal tempString, %edi
movl $10, %ebx             # carica 10 in EBX (usato per le divisioni)
movl $0, %ecx              # azzera il contatore ECX
continua_a_dividere:
movl $0, %edx              # azzera il contenuto di EDX
divl %ebx                  # divide per 10 il numero ottenuto
addb $48, %dl              # aggiunge 48 al resto della divisione
movb %dl, (%edi,%ecx,1)    # sposta il contenuto di DL in numtmp
inc %ecx                   # incrementa il contatore ECX
cmp $0, %eax               # controlla se il contenuto di EAX è 0
jne continua_a_dividere
movl $0, %ebx              # azzera un secondo contatore in EBX
ribalta:
movb -1(%edi,%ecx,1), %al  # carica in AL il contenuto dell'ultimo byte di 'numtmp'
movb %al, (%esi,%ebx,1)    # carica nel primo byte di 'numstr' il contenuto di AL
inc %ebx                   # incrementa il contatore EBX
loop ribalta
fineNum2Str:
movb $0, (%esi,%ebx,1)    # aggiunge il carattere '\0' in fondo a 'numstr'
popl %edx
popl %ecx
popl %ebx
popl %eax
popl %edi
ret

# Concatena "LOW" alla stringa fornita in esi con relativo offset
# Input: ESI
# Output: ESI
# outputOffsed modified (%eax)
.type appendLow, @function
appendLow:
movb $76, (%esi, %eax)
incl %eax
movb $79, (%esi, %eax)
incl %eax
movb $87, (%esi, %eax)
incl %eax
ret

# Concatena "MEDIUM" alla stringa fornita in esi con relativo offset
# Input: ESI
# Output: ESI
# outputOffsed modified (%EAX)
.type appendMedium, @function
appendMedium:
movb $77, (%esi, %eax)
incl %eax
movb $69, (%esi, %eax)
incl %eax
movb $68, (%esi, %eax)
incl %eax
movb $73, (%esi, %eax)
incl %eax
movb $85, (%esi, %eax)
incl %eax
movb $77, (%esi, %eax)
incl %eax
ret

# Concatena "HIGH" alla stringa fornita in esi con relativo offset
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
 