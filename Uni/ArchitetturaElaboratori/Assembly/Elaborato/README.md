# Elaborato Assembly

- Giri motore
- Temperatura motore
- Velocità

Però i dati sono per tutti i piloti

|ID PILOTA|NOME PILOTA|SPEED|RPM|TEMPERATURA| <br>
Tutti i valori sono interi. Tranne il tempo che, però, verrà gestito come una stringa. <br>
I campi sono separati da una virgola ','. <br>

***Nella prima riga del file di input è presente il nome del pilota da monitorare*** <br>

Quando il parametro sta in soglia basse/media/alta, va riportato <br>

Output: <tempo>,<livello rpm>,<livello temperatura>,<livello velocità> <br>
Ultima riga del file: <rpm max>,<temp max>,<velocità max>,<velocità media> <br>
  
1) Giri Motore:
    - LOW: rpm <= 5000
    - MEDIUM: 5000 < rpm <= 10000
    - HIGH: rpm > 10000
2) Temperatura Motore:
    - LOW: temp <= 90
    - MEDIUM: 90 < temp <= 110
    - HIGH: temp > 110 
3) Velocità:
    - LOW: speed <= 100
    - MEDIUM: 100 < speed <= 250
    - HIGH: speed > 250
  
  ***Se il nome del pilota è invalido ritorna la stringa 'invalid'***
