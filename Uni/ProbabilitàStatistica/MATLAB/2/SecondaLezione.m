%{

% Secondo Esercizio
load sunspot.dat;       % Carico il dat (già presente in matlab)
year = sunspot(:,1);
spots = sunspot(:,2);

figure(1)
plot(year, spots, 'r*');
title('Sunspots by year');
xlabel('Years');
ylabel('Sunspots');

figure(2);
% |Matrix X|Matrix Y|Element Position|
subplot(2,2,1), area(year, spots);
subplot(2,2,2), bar(year, spots);
subplot(2,2,3), barh(year, spots);
subplot(2,2,4), histogram(spots);

%}

%{

% Terzo Esercizio
temp = [0 3 6 9 12 15 18 21; 55.5 52.4 52.6 55.7 75.6 77.7 70.3 66.6];
dayTime = temp(1, :);
misuredTemp = temp(2, :);
figure(1);
plot(dayTime, misuredTemp, 'k+');
% xFrom, xTo, yFrom, yTo
axis([-1 25 50 80]);

%}

% STATISTICA DESCRITTIVA
% help stats -> Per avere help sulla statistica descrittiva
% Centralità, forma e dispersione: mean, median, mode, std, var, skewness, kurtosis
% nanmean - Ignora i valori NaN per fare la media
% Operano per colonna!
[media, stdev] = mean_std([3 8 5 3 4 1 8]);

% Range e Percentili
% range, max, min, iqr, prctile, quantile
% boxplot, tabulate, corrcoef
% Anche questi, con matrici, operano per colonna!

%{

% ISTOGRAMMA: - Deprecato, ma, per gli scopi attuali va bene.
hist(y);        % Genera istogramma con divisione in 10 classi
hist(y,n);      % Genera istogramma con divisione in <n> classi
hist(y, x);     % Dove <x> è un vettore che centra le classi
% randn(<intervallo>) genera una distribuzione di dati normali
[counts, centers] = hist(x);    % Richiediamo il numero di elementi di una classe con il relativo centro
bar(centers, counts);           % Creiamo un grafico a barre identico (stessi dati) all'istogramma
% [counts, centers] = TABELLA DI FREQUENZA

%}

% Esercizio: %
                 % |Numero righe|Numero Colonne|
randValues = rand(10, 1);
sampleMean = mean(randValues)
sampleMedian = median(randValues)
sampleStd = std(randValues)
sampleVariance = var(randValues)

figure(1)
boxplot(randValues)
figure(2)
boxplot(randValues, 'orientation', 'horizontal')

quantile(randValues, .25)
quantile(randValues, .50)
quantile(randValues, .75)

prctile(randValues,40)









