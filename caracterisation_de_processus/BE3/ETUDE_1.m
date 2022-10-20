close all; clear all; clc;

%% Partie 1
% Déclaration des paramètres temporelles et fréquencielles
duree = 1; % durée des signaux
fe = 1000; % fréquence d'échantillonnage
N = round(fe * duree); % nombre d'échantillon de x1 et x2
t = (0:N-1)./fe; % Vecteurs temporelles de x1 et x2


% Déclaration des signaux
f1 = 50;
A1 = 1;
x1 = A1*cos(2*pi*f1*t);

f2 = 100;
A2 = 1;
x2 = A2*cos(2*pi*f2*t);

x = [x1, x1+x2, +x2];

N_x = length(x); % Nombre d'échantillon de x
t_x = (0:N_x-1)./fe; % Vecteur temporelle du signal x


% Calcul du spectre en amplitude en -fe/2 et fe/2
Nfft = N_x;
fftx = fft(x, Nfft);  % Spectre d'amplitude entre [0,fe]
fftx = fftshift(fftx); % Spectre en [fe/2 fe/2]
freq = -fe/2:fe/Nfft:((fe/2)-(fe/Nfft)); % fenêtre centré en [fe/2 fe/2]



%%
%%Partie 2
xa = hilbert(x); % Transformé de Hilbert (forme analytique du signal)


% Calcul du spectre en amlpitude en -fe/2 et fe/2 de la transformé de Hilbert
fftxa = fft(xa, Nfft);  % Spectre d'amplitude entre [0,fe]
fftxa = fftshift(fftxa); % Spectre en [fe/2 fe/2]
freq = -fe/2:fe/Nfft:((fe/2)-(fe/Nfft)); % fenêtre centré en [fe/2 fe/2]


% Calcul des grandeurs instantannée
ai = abs(xa); % Amplitude instantannée
fi = (fe/(2*pi)) * (diff(angle(xa))); % diff() -> dérivée partielle, angle() -> argument 
fiFilt = medfilt1(fi, 3);    % Estimation de FI avec un filtrage median de taille 3 (compense les erreurs causé par diff())

figure; instfreq(xa, fe, 'Method', 'hilbert'); % Autre méthode matlab pour afficher la fréquence instantané
[p, f, t] = pspectrum(xa, fe, 'spectrogram');  % Encore une autre
figure; instfreq(p, f, t);

figure;
subplot(121);
plot(t_x(1:length(fi)), fi);
title("Fréquence instantanné sans filtrage médian");
xlabel('Temps'); ylabel('Fréquences');

subplot(122);
plot(t_x(1:length(fiFilt)), fiFilt);
title("Fréquence instantanné avec filtrage médian");
xlabel('Temps'); ylabel('Fréquences');


% Affichage de la représentation temporelle et fréquencielle
figure;
subplot(221);
hold on;
plot(t_x, x); 
plot(t_x, ai); 
title("Temporelle du sinal x");
xlabel('Temps'); ylabel('Amplitude'); 
legend('signal x', 'Amplitude instantanné');

subplot(222);
plot(freq, fftx);
title("Fréquencielle du sinal x");
xlabel('Fréquences'); ylabel('Amplitude')

subplot(223);
plot(real(xa), imag(xa), '-b.');
title("Temporelle transformé de Hilbert (Signal analytique)");
xlabel('Temps'); ylabel('Amplitude'); 

subplot(224);
plot(freq, fftxa);
title("Fréquencielle transformé de Hilbert");
xlabel('Fréquences'); ylabel('Amplitude')

%% Partie 3
% Méthode 1
nfft = 512;
win = hann(nfft);
noverlap = ceil(nfft/3);
figure; hold on; grid on; 
spectrogram(x, win, noverlap, nfft, fe, 'yaxis');
title("Méthode 1");
xlabel('Temps'); ylabel('Fréquence (Hz)');
axis([0.08 2.81 0 round(fe/2)]);

%Méthode 2
[TFR, ftfr, ttfr] = spectrogram(x, win, noverlap, nfft, fe, 'yaxis');
figure; hold on; grid on;
imagesc(ttfr, ftfr, 10*log10(abs(TFR)));
title("Méthode 2");
xlabel('Temps'); ylabel('Fréquence (Hz)');
axis xy; axis tight; colormap("jet");











