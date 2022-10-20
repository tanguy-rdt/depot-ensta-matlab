%% Version Prof
close all; clear all; clc;

%% GENERATION du signal 
N  = 2048; % 2048 
fe = 510;  % 510
f1 = 20; A1 = 1;
f2 = 30; A2 = 0.1;
f3 = 40; A3 = 1;
t  = (0:N-1)./fe;
x1 = A1*cos(2*pi*f1*t);
x2 = A2*cos(2*pi*f2*t);
x3 = A3*cos(2*pi*f3*t);
var_bruit = 0.2;
bruit     = sqrt(var_bruit)*randn(1,N);
x         = x1 + x2 + x3 + 1*bruit; 

% Estimation du SNR (question 6 partie 1)
var_signal = std(x1 + x2 + x3).^2;  % Variance du signal avec bruit
var_bruit  = std(bruit).^2;         % Variance du bruit uniquement
SNR        = var_signal/var_bruit;
SNR_dB     = 10*log10(SNR)

E_signal = sum((x1 + x2 + x3).^2);  % Energie du signal avec bruit
E_bruit  = sum(bruit.^2);           % Energie du bruit uniquement
SNR      = E_signal/E_bruit;
SNR_dB   = 10*log10(SNR)

% Affichage signal temporel
figure(1);
subplot(221); hold on; grid on;
plot(t, x, 'b'); 
xlabel(' temps'); ylabel(' Amplitude'); 

%% SPECTRE d'amplitude
Nfft = N;                           % Nbre d'echantillons en fréquence
fftx = abs(fft(x,Nfft));            % Spectre d'amplitude
freq = -fe/2 : fe/Nfft : fe/2-fe/Nfft;  % Echelle des fréquences freq = linspace(-fe/2,fe/2,Nfft);

% Affichage du spectre d'amplitude 
figure(1);
subplot(223); hold on; grid on; 
plot(freq, fftshift(fftx), 'b'); 
xlabel(' Fréquence'); ylabel(' | Spectre | linaire'); 

subplot(224); hold on; grid on; 
plot(freq, 20*log10(fftshift(fftx)), 'b'); 
xlabel(' Fréquence'); ylabel(' | Spectre | dB'); 

% Detection des max : ici on en cherche 3
[Frequence0, Amplitude0] = AfficheMaxFreq(fftshift(fftx), freq, 3);

%% PERIODOGRAMME simple
Px0 = Periodogram_Moi(x);

% Affichage du Periodogramme simple
figure(2);
subplot(221); hold on; grid; 
plot(freq, 20*log(fftshift(Px0)), 'r');
xlabel(' Fréquence'); ylabel(' DSP dB'); 
title(' Periodogramme');

% Detection des max : ici on en cherche 3
[Frequence11, Amplitude11]=AfficheMaxFreq(fftshift(Px0), freq, 3);

%% PERIODOGRAMME modifié
% Effet du fenetrage sur tout le signal,pas de recouvrement
% typefen = 2; % numero de la fenetre [0 5]
% Px1     = Periodogram_Modifie_Moi(x, typefen); 
% 
% % Affichage
% figure(2);
% subplot(222); hold on; grid; 
% plot(freq, 20*log(fftshift(Px1)), 'r');
% xlabel(' Fréquence'); ylabel(' DSP dB'); 
% title(' Periodogramme modifié');
% 
% % Detection des max : ici on en cherche 3
% [Frequence22, Amplitude22]=AfficheMaxFreq(fftshift(Px1), freq, 3);

%% EFFET FENETRAGE pour le Periodogramme modifié
Px_1 = Periodogram_Modifie_Moi(x, 1); 
Px_2 = Periodogram_Modifie_Moi(x, 2); 
Px_3 = Periodogram_Modifie_Moi(x, 3);
Px_4 = Periodogram_Modifie_Moi(x, 4);
Px_5 = Periodogram_Modifie_Moi(x, 5);

% Affichage echelle en dB
figure(3);
subplot(231); hold on; grid;
plot(freq, 20*log(fftshift(Px_1)), 'b'); title(' DSP triangle ');
subplot(232); hold on; grid;
plot(freq, 20*log(fftshift(Px_2)), 'b'); title(' DSP Hamming ');
subplot(233); hold on; grid;
plot(freq, 20*log(fftshift(Px_3)), 'b'); title(' DSP Hanning ');
subplot(234); hold on; grid;
plot(freq, 20*log(fftshift(Px_4)), 'b'); title(' DSP Bartlett');
subplot(235); hold on; grid;
plot(freq, 20*log(fftshift(Px_5)), 'b'); title(' DSP Blackman');
subplot(236); hold on; grid;
plot(freq, 20*log(fftshift(Px0)), 'b'); title(' DSP periodogramme simple');

%% ETUDE BARTLETT 
% Division du signal en K blocs, pas de recouvrement entre les blocs, 
% DSP du signal estimée par moyennage des DSP de tous les blocs 
K      = 8;             % Nombre de blocs 4, 5, 32, 64
Px2    = Bart(x, K); 
freqBa = -fe/2 : fe/length(Px2) : fe/2 - fe/length(Px2); % Echelle des frequences freqBa = linspace(-fe./2,fe./2,length(Px2));

% Affichage
figure(2);
subplot(223); hold on; grid; 
plot(freqBa, 20*log(fftshift(Px2)), 'r');
xlabel(' Fréquence'); ylabel(' DSP dB'); 
title(' Periodogramme de Bartlett');

% Detection des max : ici on en cherche 3
[Frequence33, Amplitude33] = AfficheMaxFreq(fftshift(Px2), freqBa, 3);


% %% ETUDE WELCH 
% Completer le code ci-dessous :
% Division du signal en K blocs, avec un recouvrement entre les blocs, 
% Fenetrage du chaque blocs
% DSP du signal estimée par moyennage des differentes DSP des blocs 
% En fait, on se retrouve à faire la moyenne de plusieurs périodogramme
% modifié
typefen = 2;   % numero de la fenetre [0 5]
L       = 256; % Nombre de points pas blocs 150
overlap = 0.25; % Taux de recouvrement entre les blocs: ]0 1[  
Px3     = Welch(x, L, overlap, typefen); 
freqWe  = -fe/2 : fe/length(Px3) : fe/2-fe/length(Px3); % Echelle des frequences % freqWe  = linspace(-fe./2,fe./2,length(Px3)); 

% Affichage
figure(2);
subplot(223); hold on; grid; 
plot(freqWe, 20*log(fftshift(Px3)), 'r'); % plot(...) en dB
xlabel(' Fréquence'); ylabel(' DSP dB'); 
title(' Periodogramme de Welch');

% Detection des max : ici on en cherche 3
[Frequence33, Amplitude33] = AfficheMaxFreq(fftshift(Px3), freqWe, 3);

