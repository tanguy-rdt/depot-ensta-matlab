clear all; close all; clc;
%% Chargement et affichage de l'ECG
load ECG.dat
fe=500;

figure;
pwelch(ECG);

%% Filtre RIF à phase linéaire et de fréquence de coupure 40Hz
% on remarque une linéarité dans la bande passante, ce qui est la
% caractéristique importante d'un filtre RIF. Le filtre RIF et a phase
% linéaire, il y a pas de dépendance.
g=fir1(20, 0.16);
figure;
freqz(g, 1, 2000);

%% Filtre RII de Butterworth de fréquence de coupure 40 Hz
% si on se place à -3dB on retrouve la freq f0, soit 0.15, la fréquence que
% le filtre renvoie.
[N, Wn]=buttord(0.14, 0.18, 0.5, 20);
[b, a]=butter(N, Wn);
figure;
freqz(b, a, 2000);

%% Filtrage du ECG
ecg_filter1=filter(g, 1, ECG);
ecg_filter2=filter(b, a, ECG);

% on constate que la composante à 50Hz est mieux filtré avec le RII, on
% peut le voir fréquenciellement
figure;
subplot(3, 1, 1);
pwelch(ECG);
title("ECG initial");
subplot(3, 1, 2);
pwelch(ecg_filter1);
title("ECG filtré avec le RIF");
subplot(3, 1, 3);
pwelch(ecg_filter2);
title("ECG filtré avec le RII");

% Mais aussi temporellement
figure;
subplot(3, 1, 1);
plot(ECG);
title("ECG initial");
subplot(3, 1, 2);
plot(ecg_filter1);
title("ECG filtré avec le RIF");
subplot(3, 1, 3);
plot(ecg_filter2);
title("ECG filtré avec le RII");

% le pb avec des ecg on a des pic et des creux, avec le RII certain creux
% disparaissent. Sauf que c'est des informations qui peuvent être
% importante. Donc le filtre qui conserve le mieux les informations et qui
% filtre la composante est le RIF, la phase linéaire ne filtre pas les
% complexes.



