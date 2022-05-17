# Installazione di TomCat

## Note Iniziali
Si ritiene **necessario** eseguire tutti i comandi sottostanti da **sudo!** <br>
Utilizzare SSH se si pensa che possa rendere il tutto più comodo. <br>


## :gear: Fase 1 - Preparazione del S.O. & Installazione di Java

Per aggiornare i programmi presenti nel sistema operativo eseguire i seguenti comandi: <br>
>         apt-get update
>         apt-get upgrade

Digitare il seguente comando:
>        java -version

* Nel caso in cui java non fosse presente sarà visualizzato il seguente messaggio: <br>
![JavaNotFound](/TomCat/Immagini/JavaNotFound.png) <br>
In questo caso basterà digitare ciò che ci viene suggerito, per esempio: <br>
>         apt-get install openjdk-15-jre

* Altrimenti sarà visualizzato un messaggio simile al seguente: <br>
![JavaFound](/TomCat/Immagini/JavaFound.png) <br>
In quest'altro caso, invece, si può procedere alla prossima fase.

### CheckPoint
Se il seguente comando mostra che Java è presente sul sistema, è stato installato tutto correttamente!
>       java -version


## :gear: Fase 2 - Installazione di Tomcat

**Facoltativo** Il primo passaggio di affrontare prima della installazione di TomCat è quello di creare un utente apposito per la gestione di Apache TomCat: <br>
>         useradd -b /bin/bash -d /opt/tomcat -m username
_Nota: la directory può anche essere diversa da quella sopra idicata. In questo caso bisognerà scaricare, estrarre ed eseguire TomCat da lì._

Spostarsi nella directory nella quale si vuole scaricare e, in seguito, installare TomCat tramite il seguente comando:
>         cd directory
_Nota: La directory consigliata è quella utilizzata durante la creazione dell'utente, in questo caso /opt/tomcat_

Una volta fatto ciò bisogna scaricare il programma:
1) Se si utilizza ubuntu tramite GUI basterà andare sul sequente [sito](https://tomcat.apache.org/download-90.cgi) e scaricare il file che finisce per .tar.gz

2) Se si vuole fare, invece, tramite linea di comando basterà usare il seguente comando:
>         wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz

Estrarre il programma appena scaricato:
>         tar -xzvf fileName
_Note: se non riesci a estrarre il programma significa che il file scaricato non è quello desiderato. Di conseguenza è consigliato provare a riscaricarlo controllando che il comando sia stato scritto correttamente._

Una volta fatto ciò eliminare i file inutili presenti nella cartella e spostare i file presenti nella cartella estratta in tomcat: <br>
>         rm [fileName]
>         mc [fileName] [newPath]

Infine creare un'eccezione nel firewall: <br>
>         udw allow 8080

### CheckPoint
Se eseguendo i seguenti comandi notiamo che è presente la cartella decompressa, significa che abbiamo eseguito tutte le procedure correttamente:
>         cd /opt/tomcat/
>         ls


## :gear: Fase 3 - Avviare il programma:

Per avviare il programma basterà eseguire il seguente comando: <br>
>         ./op/tomcat/bin/startup.sh

Avviare lo script di TomCat all'avvio del sistema: <br>
Per fare ciò ci sono più possibilità, io ho utilizzato **/rc.local**. <br>
Per fare ciò modificare, se già presente oppure creare il seguente file: <br>
>         nano /etc/rc.local
Una volta fatto ciò inserire le seguenti righe: <br>
>         #! /bin/bash
>         [PercorsoDelloScript]
>         exit 0
_Nota: Guarda il [File di esempio](/TomCat/Files/rc.local) se hai dubbi_

Infine rendere il file eseguibile: <br>
>         chmod +x /etc/rc.local

Una volta fatto ciò TomCat sarà "Up and running"!

### CheckPoint
Per controllare che TomCat si avvii in automatico basta riavviare il computer ed eseguire i seguenti passaggi: <br> <br>
* Se si utilizza ubuntu con GUI per controllare che TomCat sia in funzione basta digitare localhost:8080. <br> <br>
![TomCatUbuntu](/TomCat/Immagini/TomCatUbuntu.png) <br>
* Altrimenti basta digitare ipDellaMacchinaConTomcat:8080. <br> <br>
![TomCatWindows](/TomCat/Immagini/TomCatWindows.png) <br>


## :gear: Fase 4 - Ultime configurazioni

Come ultimo passaggio basta configurare l'username per gestire TomCat: <br>
>         <role rolename="manager-gui" />
>         <role rolename="admin-gui" />changes
>         <user username="admin" password="password" roles="manager-gui,admin-gui"/>
Aggiungere, quindi, le righe precedenti come in [questo file](/TomCat/Files/tomcat-users.xml). <br>

Infine riavviare TomCat ed il gioco è fatto!
>         systemctl restart tomcat

### CheckPoint:
Per controllare se i cambiamenti siano stati effettuati con successo basta provare, quando richiesto, di inserire username e password! <br>
