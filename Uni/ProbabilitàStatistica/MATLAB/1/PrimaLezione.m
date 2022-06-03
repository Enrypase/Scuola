A = [1 2; 3 4];         % Creazione di una matrice
% help <nomeFunzione> / doc <nomeFunzione> - Mostrano documentazione sulla funzione
% lookfor <parolaChiave> -all - Mostra tutte le funzioni con <parolaChiave> all'interno
primoValore = 100;
primoValore = 102;
% clear / clear <nomeVariabile> - pulisce il Workspace
arrayRiga = [1 2 3];
arrayColonna = [1; 2; 3];

arrayRiga(1);       % Per accedere agli elementi di un array

finewArray = [primoArray, secondoArray];      % Per la concatenazione dei vettori. Devono essere della stessa dimensione

x = primoValoreVettore:currentValue:ultimoValoreVettore;        % Permette di generare un vettore con i valori inseriti
linspace(primoPunto,secondoPunto, numeroDielementi)             % Permette di generare un vettore con i valori inseriti

A(:, 2);    % Permette di accedere a tutte le righe della colonna 2
A(:, 2:4);  % Selezioniamo tutte le righe e le colonne da 2 a 4
A(1 : 3, 3 : 5)     % Creazione di una sotto-matrice

V = A(:)    % Mettiamo tutte le colonne di A nell'array V
A(end, :)   % Valore dell'ultima riga e tutte le colonne

zeros(4, 4);        % Permette la creazione di matrici/array nulli delle dimensioni specificate
ones(4, 4);
rand(4, 4);
magic(4 ,4);        % Somma di righe/colonne/diagonali sono uguali

B = [A A+32; A+48 A+16];        % Concatenazione di matrici

vettore'; % Permette di ribaltarlo, se riga diventa colonna e viceversa

cell(dim1,dim2)     % All'interno di una cella si possono inserire delle altre matrici

% Per memorizzare posizioni di un elemento [k,j] = find(<elemento>)

length(<vettore>); % Restituisce la dimensione del vettore. Mentre per le matrici restituisce la dimensione più grande
size(<matrice>);   % Restituisce entrambe le dimensioni
max(<matrice/vettore>);         % Valore minimo/massimo di elementi

sum(<vettore/matrice>);         % Fa la somma degli elementi del vettore/matrice in base ai parametri specificati

% PLOTTING:
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y);
xlabel('x = 0:2\pi')
ylabel('sin(x)')
title('Title of the plot')

% GRAFICO A BARRE
figure(1); bar(asseX, asseY)
axis([<intervalloX> <intervalloY>])
xlabel('NomeX')
ylabel('nomeY')

% GRAFUCI A TORTA
strength = [1 2 3 4 5]; % Peso delle classi
Labels = {'Classe1', 'Classe2'}; 
figure(1);
pie(strength)       % Passando un vettore come secondo parametro è possibile staccare i settori di torta. Terzo parametro permette di displayare le Labels al posto delle %

% LINE GRAPH
t = randi (10, 100, 1);     % Genera 100 elementi tra 1 e 10
[counts, centers] = hist(t,unique(t));      % Conta il numero di elementi

figure(1);
stem(centers, counts) % Genera il grafico 2d
xlabel()
ylabel()
axis([0 11, -1 max(counts)+1])

save nomeFile.mat % Salva le variabili dello workspace
load nomeFile     % Carica il file


% SCRIPT = Non accettano argomenti in input né ritornano in output. Operano sui dati del workspace
% FUNCTIONS: Nome di funzione e di file meglio siano uguali
function [output1 output2] = nomeFunzione(input1, input2);


