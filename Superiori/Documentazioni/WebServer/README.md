
<!-- Il documento è suddiviso in Passi;
In ogni passo c'è la sezione Comandi e la sezione Checkpoint;
Ognuna di queste sezioni contiene tutti i comandi necessari a portare a termine l'obiettivo del determinato passo, se nella sezione Comandi, oppure a controllare l'operato, se nella sezione Checkpoint;
In ogni comando è contenuta una descrizione di esso, se non riguarda un file, l'immagine dell'invio del comando con il relativo output dalla macchina, altrimenti è presente un link al file del quale si sta parlando.

Enjoy!! -->

# DOCUMENTAZIONE WEB-SERVER

## PROCESSO DI INSTALLAZIONE


### **Passo 1:**
Il primo passo per configurare un server web è quello di assegnare a esso un IP statico, in modo tale che si possa raggiungere agevolmente e sempre con lo stesso indirizzo la determinata macchina;

- **Comandi:** :computer: <br>
Per l'eseguzione dei seguenti comandi è necessario che l'utente sia **root**.

>         apt-get install net-tools
:diamonds: Descrizione: <br>
_Questo comando permetterà l'installazione di tools utili per la verifica dello stato del network e delle varie interfacce di rete._ <br>
:diamonds: Immagine: <br>
![NetTools-Installation](/WebServer/Immagini/NetTools.png "Imagine")

>         nano /etc/netplan/00-installer-config.yaml
:diamonds: Descrizione: <br>
_Con questo comando, invece, andremo ad aprire il file di testo "00-installer-config.yaml" dove ci sono le varie configurazioni di rete della macchina._ <br>
:diamonds: File di esempio: [File](/WebServer/Files/00-installer-config.yaml)

>         netplan try
:diamonds: Descrizione: <br>
_Questo comando, più avanzato rispetto a ***netplan apply*** permette di verificare la correttezza semantica del file modificato in precendeza. Se tutto dovesse risultare corretto sarà possibile applicare le modifiche premendo invio._ <br>
:diamonds: Immagine: <br>
![NetplanTry-Command](/WebServer/Immagini/NetplanTry.png "Imagine")

- **Checkpoint:** :heavy_exclamation_mark: <br>
I seguenti passi saranno utili per confermare l'effettivo esito dei passaggi sopra eseguiti.

>         ifconfig
:diamonds: Descrizione: <br>
_Con questo comando verranno visualizzate tutte le interfacce di rete. Basterà quindi verificare che quella interessata abbia l'indirizzo IP inserito in precedenza per vedere se le impostazioni sono state applicate correttamente e definitivamente. Potremmo utilizzare anche il comando **ip addr**._ <br>
:diamonds: Immagine: <br>
![IfConfig-Command](/WebServer/Immagini/IfConfig.png "Imagine")

>         wget www.google.com
:diamonds: Descrizione: <br>
_Questo comando è preferibile a ***ping [indirizzo]*** essendo che i pacchetti di quest'ultimo potrebbero essere scartati dai router, mentre quelli FTP inviati tramite wget no. Se la richiesta del sito (in questo caso Google) va a buon fine, significa che l'indirizzo inserito nei file di configurazione è compatibile con la nostra rete e permette la navigazione nel World Wide Web._ <br>
:diamonds: Immagine: <br>
![WGet-Command](/WebServer/Immagini/WGet.png "Imagine")


### **Passo 2:**
In questo passo andremo a installare un client che permette l'accesso SSH alla macchina. Così facendo questa sarà raggiungibile da tutte le altre macchine presenti in rete;

- **Comandi:** :computer: <br>
Per l'eseguzione dei seguenti comandi è necessario che l'utente sia **root**.

>         apt-get install openssh-server
:diamonds: Descrizione: <br>
_Questo comando permette di installare un servizio SSH server e, di conseguenza, rende la macchina raggiungibile da altre in rete e utilizzabile da esse tramite shell._ <br>
:diamonds: Immagine: <br>
![OpenSSH-Installation](/WebServer/Immagini/OpenSSH.png "Imagine")

- **Checkpoint:** :heavy_exclamation_mark: <br>
I seguenti passi saranno utili per confermare l'effettivo esito dei passaggi sopra eseguiti.

>         systemctl status ssh.service
:diamonds: Descrizione: <br>
_Questo comando permette la visualizzazione dello stato del processo relativo a SSH. Un altro comando per verificare la presenza del servizio SSh è ***netstat***. Se in uno di questi due comandi risulta un processo in ascolto sulla porta SSH (Porta 22), significa che l'installazione del programma è andata a buon fine._ <br>
:diamonds: Immagine: <br>
![OpenSSH-Verify](/WebServer/Immagini/SSHStatus.png "Imagine")


### **Passo 3:**
In questo passo effetueremo l'installazione di Apache Server, in modo tale da rendere possibile alla macchina rendere il servizio di Web-Server;

- **Comandi:** :computer: <br>
Per l'eseguzione dei seguenti comandi è necessario che l'utente sia **root**.

>         apt-get install apache2
:diamonds: Descrizione: <br>
_Con questo comando verrà installato il Web-Server Apache._ <br>
:diamonds: Immagine: <br>
![Apache2-Installation](/WebServer/Immagini/ApacheInstallation.png "Imagine")

- **Checkpoint:** :heavy_exclamation_mark: <br>
I seguenti passi saranno utili per confermare l'effettivo esito dei passaggi sopra eseguiti.

>         systemctl status apache2.service
:diamonds: Descrizione: <br>
_Come per OpenSSH, anche qui possiamo optare tra questo comando e ***netstat***._ <br>
:diamonds: Immagine: <br>
![Apache2-Verify](/WebServer/Immagini/ApacheStatus.png "Imagine")

### **Passo 4:**
In questo passo installeremo il client FTP in modo tale da permettere tale accesso sulla macchina e, di conseguenza, poter modificare e trasferire files da macchine in rete alla macchina sulla quale stiamo lavorando;

- **Comandi:** :computer: <br>
Per l'eseguzione dei seguenti comandi è necessario che l'utente sia **root**.

>         apt-get install vsftpd
:diamonds: Descrizione: <br>
_Con questo comando verrà installato il client FTP vsftpd sulla macchina._ <br>
:diamonds: Immagine: <br>
![VSFTPD-Installation](/WebServer/Immagini/VsftpdInstallation.png "Imagine")

>         nano /etc/vsftpd.conf
:diamonds: Descrizione: <br>
_Con questo comando, invece, andremo ad aprire il file di testo "vsftpd.conf" dove ci sono le varie configurazioni del programma FPT appena installato. Per fare in modo che tutte le operazioni di trasferimento siano possibili e vadano a buon fine è fortemente consigliato copiare il seguente file._ <br>
:diamonds: File di esempio: [File](/WebServer/Files/vsftpd.conf)

>         systemctl reload vsftpd.service
:diamonds: Descrizione: <br>
_Questo comando permette di riavviare il servizio FTP, così facendo, applicando le impostazioni appena modificate nel relativo file._ <br>
:diamonds: Immagine: <br>
![VSFTPD-Reload](/WebServer/Immagini/VsftpdReload.png "Imagine")

- **Checkpoint:** :heavy_exclamation_mark: <br>
I seguenti passi saranno utili per confermare l'effettivo esito dei passaggi sopra eseguiti.

>         systemctl status vsftpd.service
:diamonds: Descrizione: <br>
_Come in precedenza è possibile controllare lo stato del servizio anche tramite ***netstat***._ <br>
:diamonds: Immagine: <br>
![VSFTPD-Status](/WebServer/Immagini/VsftpdStatus.png "Imagine")


### **Passo 5:**
**(Opzionale ma fortemente consigliato)** Per l'installazione di un Web-Server è preferibile che ogni utente abbia a disposizione una determinata zona del File-System della macchina.
Per fare ciò bisogna creare degli utenti i quali possiedono una determinata home (diversa da quella del root) contenente tutti i file dei quali l'utente potrebbe necessitare. In questo caso i file di Log e i vari HTML, CSS, Script, file multimediali eccetera eccetera;

- **Comandi:** :computer: <br>
Per l'eseguzione dei seguenti comandi è necessario che l'utente sia **root**.

>         useradd -s /bin/bash -d [homeDirectory] -m [nomeUtente]
:diamonds: Descrizione: <br>
_Comando che permette la creazione di un utente. Con **-s** diamo a disposizione dell'utente la **bash**; con **-d** diamo all'utente una **home directory**; con **-m** assegnamo all'utente il relativo **nome**. Da notare che se la directory inserita esiste già non verrà apportata alcuna modifica, mentre se non esiste verrà creata impostando correttamente i vari permessi all'utente relativo._ <br>
:diamonds: Immagine: <br>
![Useradd-Command](/WebServer/Immagini/useradd.png "Imagine")

>         passwd [nomeUtente]
:diamonds: Descrizione: <br>
_Con questo comando sarà possibile impostare una password all'utente specificato. Per ragioni di sicurezza la password sarà richiesta due volte._ <br>
:diamonds: Immagine: <br>
![Passwd-Command](/WebServer/Immagini/passwd.png "Imagine")

- **Checkpoint:** :heavy_exclamation_mark: <br>
I seguenti passi saranno utili per confermare l'effettivo esito dei passaggi sopra eseguiti.

>         Accesso tramite FTP-Client
:diamonds: Descrizione: <br>
_Per verificare che l'utente sia stato creato effettivamente si può tentare l'accesso tramite client FTP, per esempio Filezilla Client. Nel caso in cui ci fossero dei problemi con dei permessi nel trasferimento, bisogna tornare sulla macchina e digitare ***chown -R [nomeUtente]:[nomeUtente] [directoryCartella]***.
Se nonostante questo ci fossero comunque dei problemi con dei permessi bisogna eseguire il seguente comando: ***chmod +rwx [directoryCartella]***.
Se ci fossero comunque problemi bisogna controllare il file di configurazione di vsftpd (FTP)._ <br>
:diamonds: Immagine: <br>
![FTP-Login](/WebServer/Immagini/Filezilla.png "Imagine")


### **Passo 6:**
In questo ultimo passo concluderemo la configurazione di Apache impostando la gestione di uno o più siti dalla stessa macchina;

- **Comandi:** :computer: <br>
Per l'eseguzione dei seguenti comandi è necessario che l'utente sia **root**.

>         nano /etc/apache2/sites-avaiable/default-ssl.conf
:diamonds: Descrizione: <br>
Modificare il file in base alle proprie necessità. Le tre voci principali da modificare sono ***ServerName*** che contiene la URL del sito, ***DocumentRoot*** che contiene la posizione del sito nel FileSystem, ***ErrorLog*** dove deve essere indicata la posizione per i file di log relativi agli errori e ***CustomLog*** dove deve essere indicata la posizione per i file di log relativi agli accessi, richieste e altre operazioni. <br>
:diamonds: File di esempio: [File](/WebServer/Files/000-default.conf) <br>
***_ATTENZIONE, è preferibile lavorare su un altro file e non direttamente su quello di default_***

>         a2ensite [nomeFile]
:diamonds: Descrizione: <br>
_Con questo comando ordinerà ad Apache di attivare il sito specificato. Prima che sia effettivamente abilitato, però, sarà necessario utilizzare il seguente comando._
:diamonds: Immagine: <br>
![A2Ensite-Command](/WebServer/Immagini/A2Ensite.png "Imagine")

>         systemctl reload apache2
:diamonds: Descrizione: <br>
_Con questo comando verrà riavviato Apache2 in modo tale che possa rendere effettive le modifiche eseguite._ <br>
:diamonds: Immagine: <br>
![SystemctlReload-Command](/WebServer/Immagini/SystemctlApache2.png "Imagine")

- **Checkpoint:** :heavy_exclamation_mark: <br>
I seguenti passi saranno utili per confermare l'effettivo esito dei passaggi sopra eseguiti.

>         journalctl -xe
:diamonds: Descrizione: <br>
_Con questo comando sarà possibile vedere i log del sistema che comprendono anche il riavvio di Apache. In caso di problemi, tutti i possibili errori che impediscono l'avvio di Apache verranno segnalati qui._ <br>
:diamonds: Immagine: <br>
![SystemctlReload-Command](/WebServer/Immagini/ExampleJournal.png "Imagine")

>         Raggiungere la pagina dal browser
:diamonds: Descrizione: <br>
_Per verificare se il sito è raggiungibile, il modo più semplice e rapido è quello di provare a raggiungerlo da un browser qualsiasi. Se il sito comparirà significa che tutte le operazioni sono andate a buon fine. In caso di errori bisognerà controllare nuovamente i file di configurazione del sito._ <br>
:diamonds: Immagine: <br>
![Page](/WebServer/Immagini/Page.png "Imagine")

### NOTA: <br>
*Si consiglia di effettuare tutte le operazioni rispettando l'ordine con le quali sono state esposte* <br>
