%% Version eleve
close all; clear all; clc;

%% GENERATION du signal
% Completer le code ci-dessous :
N  = 2048; 
fe = 510;
f1 = 20; A1 = 1;
f2 = 30; A2 = 0.1;
f3 = 40; A3 = 1;
t  = 0:1:N-1; % Echelle des temps
t  = t/fe; % Echelle des temps
x1 = A1*cos(2*pi*f1*t);
x2 = A2*cos(2*pi*f2*t);
x3 = A3*cos(2*pi*f3*t);
var_bruit = 0.2;                       % La variance du bruit
bruit = sqrt(var_bruit)*randn(1,N); % Le bruit
x     = x1 + x2 + x3 + bruit ; % Le signal x

% Affichage signal temporel
figure(1);
subplot(221); hold on; grid on;
plot(t, x, "k"); % plot(...)
xlabel(' temps'); ylabel(' Amplitude'); 

%% SPECTRE d'amplitude
% Completer le code ci-dessous :
Nfft = N; % Nbre d'échantillons en fréquence
fftx = fft(x, Nfft);  % Spectre d'amplitude entre [0,fe]
fftx = fftshift(fftx); % spectre en [fe/2 fe/2]
freq = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

% Affichage du spectre d'amplitude (échelle lineaire/en dB) sur
% l'intervalle [-fe/2, fe/2]
figure(1);
subplot(223); hold on; grid on; 
stem(freq, fftx, "k"); % plot(...) en échelle lineaire
xlabel(' Fréquence'); ylabel(' | Spectre | linéaire'); 

subplot(224); hold on; grid on; 
plot(freq, (20*log10(fftx)), "k"); % plot(...) en dB
xlabel(' Fréquence'); ylabel(' | Spectre | dB'); 

% Detection des max : ici on en cherche 3
[Frequence0, Amplitude0] = AfficheMaxFreq(fftx, freq, 3);

%% Periodogramme simple
% Completer le code ci-dessous :
Px0 = Periodogram(x);

% Affichage
figure(2);
subplot(221); hold on; grid; 
plot(freq, 20*log(fftshift(Px0))); % plot(...) en dB
xlabel(' Fréquence'); ylabel(' DSP dB'); 
title(' Periodogramme');

%Detection des max : ici on en cherche 3
[Frequence22, Amplitude22]=AfficheMaxFreq(Px0, freq, 3); % AfficheMaxFreq(...)


%% PERIODOGRAMME modifié
% Completer le code ci-dessous :
% Fenetrage sur tout le signal, pas de recouvrement
typefen = 2; % numero de la fenetre [0 5]
Px1     = Periodogram_Modifie(x, typefen); 

% Affichage
figure(2);
subplot(222); hold on; grid; 
plot(freq, 20*log(fftshift(Px1))); % plot(...) en dB
xlabel(' Fréquence'); ylabel(' DSP dB'); 
title(' Periodogramme modifié');

% Detection des max : ici on en cherche 3
[Frequence22, Amplitude22]=AfficheMaxFreq(Px1, freq, 3); % AfficheMaxFreq(...)
% 
% %% EFFET FENETRAGE pour le Periodogramme modifié
% % Completer le code ci-dessous :
% %ps : aucun interet de prendre typefen=0 car cela revient à réaliser du
% % periodogramme simple !
% Px_1 = ; % Periodogramme modifié typefen= 1
% Px_2 = ; % Periodogramme modifié typefen= 2
% Px_3 = ; % Periodogramme modifié typefen= 3
% Px_4 = ; % Periodogramme modifié typefen= 4
% Px_5 = ; % Periodogramme modifié typefen= 5
% 
% % Affichage echelle en dB
% figure(3);
% subplot(231); hold on; grid;
% plot(freq, 20*log(fftshift(Px_1)), 'b'); title(' DSP triangle ');
% subplot(232); hold on; grid;
% plot(freq, 20*log(fftshift(Px_2)), 'b'); title(' DSP Hamming ');
% subplot(233); hold on; grid;
% plot(freq, 20*log(fftshift(Px_3)), 'b'); title(' DSP Hanning ');
% subplot(234); hold on; grid;
% plot(freq, 20*log(fftshift(Px_4)), 'b'); title(' DSP Bartlett');
% subplot(235); hold on; grid;
% plot(freq, 20*log(fftshift(Px_5)), 'b'); title(' DSP Blackman');
% subplot(236); hold on; grid;
% plot(freq, 20*log(fftshift(Px0)), 'b'); title(' DSP periodogramme simple');
% 
% %% ETUDE BARTLETT 
% Completer le code ci-dessous :
% Division du signal en K blocs, pas de recouvrement entre les blocs, 
% DSP du signal estimée par moyennage des differentes DSP des blocs 
% K      = ;            % Nombre de blocs 
% Px2    = Bart(x, K); 
% freqBa = ; % Echelle des frequences associée à Px2
% 
% % Affichage
% figure(2);
% subplot(223); hold on; grid; 
% ; % plot(...) en dB
% xlabel(' Fréquence'); ylabel(' DSP dB'); 
% title(' Periodogramme de Bartlett');
% 
% % Detection des max : ici on en cherche 3
% ; % AfficheMaxFreq(...)

% 
% %% ETUDE WELCH 
% % Completer le code ci-dessous :
% % Division du signal en K blocs, avec un recouvrement entre les blocs, 
% % Fenetrage du chaque blocs
% % DSP du signal estimée par moyennage des differentes DSP des blocs 
% % En fait, on se retrouve à faire la moyenne de plusieurs périodogramme
% % modifié
% typefen = ;   % numero de la fenetre [0 5]
% L       = ; % Nombre de points pas blocs 150
% overlap = ; % Taux de recouvrement entre les blocs: ]0 1[  
% Px3     = Welch(x, L, overlap, typefen); 
% freqWe  = ; % Echelle des frequences % freqWe  = linspace(-fe./2,fe./2,length(Px3)); 
% 
% % Affichage
% figure(2);
% subplot(223); hold on; grid; 
% ; % plot(...) en dB
% xlabel(' Fréquence'); ylabel(' DSP dB'); 
% title(' Periodogramme de Welch');
% 
% % Detection des max : ici on en cherche 3
% ; % AfficheMaxFreq(...)
