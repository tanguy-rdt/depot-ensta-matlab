%% On veut construire un signal tel que x(t)=Acos(theta(t)) 
% avec theta(t)=2piFot+pi*lambda*t^2
close all; clear all; clc;

%% Paramètres du signal
A      = 1;     % amplitude signal
duree  = 5;     % durée du signal 2s
Fo     = 1000;  % fréquence initiale de la sinusoïde
Fe     = 8000;  % fréquence d'échantillonnage

n = round(Fe*duree); % nombre de points du signal
t = [0:n-1]/Fe;      % vecteur temps

%% Lambda = 1000
lambda = 1000;  % paramètre de modulation

theta = 2*pi*Fo + pi * lambda * t.^2; 
x = A * cos(theta); % le signal en fonction theta

% Ecoute du signal
%sound(x,Fe)

% FFT
Nfft = n;
fftx = fft(x, Nfft);  % Spectre d'amplitude entre [0,fe]
fftx = fftshift(fftx); % Spectre en [fe/2 fe/2]
freq = -Fe/2:Fe/Nfft:((Fe/2)-(Fe/Nfft)); % fenêtre centré en [fe/2 fe/2]

figure; 
subplot(211); hold on; grid; 
plot(t, x, '-r.');
xlabel(' Temps'); ylabel(' Amplitude');
title("Lambda = 1000");
subplot(212); hold on; grid;
plot(freq, fftx, '.b-');
xlabel(' Frequence'); ylabel(' Spectre');

% TFCT
%[A, F, T] = ; % TFCT (utilisation de votre fonction ecrite precedemment)
%figure;
%mesh(T, F, A); 
%xlabel('Temps'); ylabel('Frequence');zlabel('Amplitude');
%shading interp
%colorbar;

% spectrogramme
nfft = 128;
win = hann(nfft);
noverlap = ceil(nfft/3);
[B,F,T] = spectrogram(x, win, noverlap, nfft, Fe, 'yaxis'); % specgram(); ou autres méthodes
figure;
pcolor(T,F,20*log10(abs(B)))
shading interp
colorbar
title("Lambda = 1000");

%% Lambda = 2000
lambda = 2000;  % paramètre de modulation

theta = 2*pi*Fo + pi * lambda * t.^2; 
x = A * cos(theta); % le signal en fonction theta

% Ecoute du signal
%sound(x,Fe)

% FFT
Nfft = n;
fftx = fft(x, Nfft);  % Spectre d'amplitude entre [0,fe]
fftx = fftshift(fftx); % Spectre en [fe/2 fe/2]
freq = -Fe/2:Fe/Nfft:((Fe/2)-(Fe/Nfft)); % fenêtre centré en [fe/2 fe/2]

figure; 
subplot(211); hold on; grid; 
plot(t, x, '-r.');
xlabel(' Temps'); ylabel(' Amplitude');
title("Lambda = 2000");
subplot(212); hold on; grid;
plot(freq, fftx, '.b-');
xlabel(' Frequence'); ylabel(' Spectre');

% TFCT
%[A, F, T] = ; % TFCT (utilisation de votre fonction ecrite precedemment)
%figure;
%mesh(T, F, A); 
%xlabel('Temps'); ylabel('Frequence');zlabel('Amplitude');
%shading interp
%colorbar;

% spectrogramme
nfft = 128;
win = hann(nfft);
noverlap = ceil(nfft/3);
[B,F,T] = spectrogram(x, win, noverlap, nfft, Fe, 'yaxis'); % specgram(); ou autres méthodes
figure;
pcolor(T,F,20*log10(abs(B)))
shading interp
colorbar
title("Lambda = 2000");

%% Lambda = 3000
%lambda = 3000;  % paramètre de modulation

theta = 2*pi*Fo + pi * lambda * t.^2; 
x = A * cos(theta); % le signal en fonction theta

% Ecoute du signal
%sound(x,Fe)

% FFT
Nfft = n;
fftx = fft(x, Nfft);  % Spectre d'amplitude entre [0,fe]
fftx = fftshift(fftx); % Spectre en [fe/2 fe/2]
freq = -Fe/2:Fe/Nfft:((Fe/2)-(Fe/Nfft)); % fenêtre centré en [fe/2 fe/2]

figure; 
subplot(211); hold on; grid; 
plot(t, x, '-r.');
xlabel(' Temps'); ylabel(' Amplitude');
title("Lambda = 3000");
subplot(212); hold on; grid;
plot(freq, fftx, '.b-');
xlabel(' Frequence'); ylabel(' Spectre');

% TFCT
%[A, F, T] = ; % TFCT (utilisation de votre fonction ecrite precedemment)
%figure;
%mesh(T, F, A); 
%xlabel('Temps'); ylabel('Frequence');zlabel('Amplitude');
%shading interp
%colorbar;

% spectrogramme
nfft = 128;
win = hann(nfft);
noverlap = ceil(nfft/3);
[B,F,T] = spectrogram(x, win, noverlap, nfft, Fe, 'yaxis'); % specgram(); ou autres méthodes
figure;
pcolor(T,F,20*log10(abs(B)))
shading interp
colorbar
title("Lambda = 3000");
