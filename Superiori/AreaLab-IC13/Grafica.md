# Descrizione grafica dell'applicazione

# Indice:
- [PAGINA LOGIN](#Pagina-di-login) :bust_in_silhouette:
- [HOME PAGE](#Home-page) :house:	

<hr>

## Pagina di Login
- [`Username`](#Username)
- [`Password`](#Password)

![a](/Immagini/Sito/Login.PNG)

### Username
In questa casella di inserimento si inserisce il nome utente.
### Password
In questa casella di inserimento si inserisce la password.

Effettuato il login si ìi ha accesso all'applicazione.

<hr>

## Home Page

- [`Priority box`](#Priority-Box)
- [`Aggiornamento corsi`](#Aggiornamento-corsi)
- [`Consulta`](#Consulta)
- [`Aggiornamento anagrafica`](#Aggiornamento-anagrafica)
- [`Ottieni foglio firme`](#Ottieni-foglio-firme)
- [`Backup` ](#Ottieni-backup)

![a](/Immagini/Sito/PaginaIniziale.PNG)

### Priority Box
- Questa box contiene delle informazioni urgenti  quali per esempio:
  - il professore x deve svolgere il corso y,z 
  - il professore a deve rinnovare il corso b
    
<hr>

### Aggiornamento corsi

- [`Aggiungi corso`](#Aggiungi-corso)
- [`Modifica corso`](#Modifica-corso)
- [`Ricerca corso`](#Ricerca-corso)
- [`VIsualizza corsi`](#Visualizza-corsi)

![a](https://github.com/Enrypase/AreaLab-IC13/blob/main/Immagini/Sito/AggiornaCorsi.PNG)

##### Aggiungi corso
- Questo bottone permette di aggiungere un corso all'elenco corsi e quindi alla tabella corsi nel database.

##### Modifica corso
- Questo bottone permette di modificare le informazioni di un corso, disattivare e attivare un corso. Avviene la modifica nel database.

##### Ricerca corso
- Questo bottone permette di cercare in particolare un corso e le relative informazioni.

##### Visualizza corsi
- Questo bottone permette di visualizzare tutti i corsi attivi.
    
<hr>

### Consulta

- [`Ordina per personale`](#Ordine-per-personale)
- [`Ordina per corso`](#Ordine-per-corso)
- [`Ricerca`](#Ricerca)

![a](https://github.com/Enrypase/AreaLab-IC13/blob/main/Immagini/Sito/Consulta.PNG)

##### Ordine per personale
- Questo bottone permette di visualizzare in ordine alfabetico la tabella relativa al personale, se clicchi nuovamente sul pulsante verrà rappresentato l'ordine delle persone in senso contrario all'alfabeto.

##### Ordine per corso
- Questo bottone permette di visualizzare in ordine alfabetico la tabella relativa ai corsise clicchi nuovamente sul pulsante verrà rappresentato l'ordine dei corsi in senso contrario all'alfabeto. Se si vuole visualizzare i corsi frequetati e frequentanti di una persona si può cliccare sul Codice Fiscale e ottenere una tabella risultato del piano cartesiano tra la tabella corsi e la tabella persona.

##### Ricerca
- Questo bottone permette di cercare un informazione( nome corso, nome persona o qualsiasi attributo della tabella), previa scelta della tabella tramite i bottoni precedenti.
    
<hr>

### Aggiornamento anagrafica

- [`Aggiungi personale`](#Aggiungi-personale)  
- [`Modifica personale`](#Modifica-personale)

![a](https://github.com/Enrypase/AreaLab-IC13/blob/main/Immagini/Sito/AggiornaAnagrafica.PNG)

##### Aggiungi personale 
- Questo bottone permette di aggiungere un utente del personale all'elenco del personale e quindi alla tabella personale nel database.

##### Modifica personale
- Questo bottone permette di modificare le informazioni di un utente del personale, di disattivarlo:ovvero che non è piu presente all'interno del plesso scolastico, oppure di riattivarlo nel caso in cui ritornasse in quella scuola.

<hr>

### Ottieni foglio firme
Questo pulsante permette al gestore di ottenere uno o più fogli di carta fisici stampati formati da un titolo "nome del corso" e 
da una tabella composta dalle informazioni del personale, il codice del corso e lo spazio nel quale apporre la firma di presenza.
Cliccando sul relativo bottone si chiederà di inserire il nome del corso. Una volta inserito il nome del corso
si otterrà una schermata stampabile formata da: 
* titolo del corso
* tabella con: 
    - nome della persona;
    - cognome della persona;
    - codice del corso;
    - spazio per la firma.
    
<hr>

### Ottieni backup
- Questo bottone permette di scaricare un file sql per il backup del database

