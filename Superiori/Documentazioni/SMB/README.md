# Configurazione Protocollo Samba

## Note Iniziali
Si ritiene **necessario** eseguire tutti i comandi sottostanti da **sudo!** <br>
Utilizzare SSH se si pensa che possa rendere il tutto più comodo. <br>
## :gear: Fase 1 - Preparazione del S.O.
Per aggiornare i programmi presenti nel sistema operativo eseguire i seguenti comandi: <br>
>     apt-get update
>     apt-get upgrade

Inoltre, è necessario controllare se Samba è presente sul sistema operativo: <br>
>     whereis samba
Il comando restituirà due output differenti. <br>
Se Samba **è presente** verrà restituita la directory dove è installato; <br>
![PercorsoTrovato](/SMB/Immagini/PercorsoTrovato.png) <br>
Se Samba **non è presente**  sarà restituito un messaggio indicante la mancata presenza del programma. <br>
![PercorsoNonTrovato](/SMB/Immagini/PercorsoNonTrovato.png) <br>
 
### CheckPoint:
Per verificare il corretto aggiornamento del sistema basta ri-eseguire i comandi sopra-elencati e se sullo schermo dovesse comparire che sono stati aggiornati 0 pacchetti, significa che sono stati già aggiornati correttamente in precedenza.


## :gear: Fase 2 - Installazione di Samba e configurazione

Se Samba non è presente, installarlo:
>     apt-get install samba

reazione di un utente per Samba: <br>
>     useradd -b /bin/bash -d /home/username/sambaFolder -m username
>     passwd username
![Username](/SMB/Immagini/Username.png) <br>
Così facendo per accedere alla cartella di Samba da quasiasi sistema si drovrà mettere username e password diverse da quelle "principali". <br>
_Nota: nel caso in cui la password sarà inferiore verrà visualizzato un messaggio indicante la mancata sicurezza di quest'ultima_ <br>

Configurazione del file di Samba: <br>
>     nano /etc/samba/smb.conf
Configurare il file come quello presente [qui](/SMB/Files/smb.conf) <br>
_Nota: di quel file sono state modificate solamente le ultime righe alle quali è stata aggiunta la sezione [sambashare] e le righe di testo presenti in essa_ <br>

Creare un'eccezione nel firewall per Samba: <br>
>     ufw allow samba
![Firewall](/SMB/Immagini/Firewall.png) <br>

Riavviare Samba: <br>
>     servive smdb restart

Per completare il tutto, aggiungere un username a Samba:
>     smbpasswd -a username
_Nota: nel caso in cui si volesse rimuovere un esername da samba è necessario utilizzare ***pdbedit -x -u username***_

### CheckPoint:
Per verificare la corretta installazione del programma basta digitare il seguente comando:
>     netstat -tuln
Se come dalla seguente figura si nota la porta 445 essere in ascolto, significa che il programma è stato installato con successo
![Netstat](/SMB/Immagini/Netstat.png)

## :gear: Fase 3 - Connessione alla cartella condivisa
> Se si utilizza **windows** basta andare nell'esplora risorse e inserire il seguente percorso: ***\\\ip-address\sharedFolder*** <br>
![ConnessioneWindows](/SMB/Immagini/ConnessioneWindows.png)

> Se si utilizza un sistema **Ubuntu** oppure ***macOS***, invece, digitare il seguente percorso: ***smb://ip-address/sharedFolder*** <br>
![ConnessioneUbuntu](/SMB/Immagini/ConnessioneUbuntu.png)

### CheckPoint:
Per verificare che tutto sia andato a buon termine non c'è altro da fare che tentare di fare l'accesso alla cartella condivisa. <br>
Se è possibile farlo significa che è stato installato e configurato tutto correttamente, in caso contrario, se sono stati tutti i checkpoint descritti in precedenza, bisognerà ricontrollare i file di configurazione.
