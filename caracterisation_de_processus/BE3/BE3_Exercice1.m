%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                          %                             %
%%   Author  :  Jean-Christophe Cexus       %            STIC             %
%%              Juillet. 2022.              %         ENSTA-Bretagne      %
%%                                          %                             %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Elemement de correction pour le BE 1 sur la Fréquence instantanée
%   - Estimation FI & AI via Hilbert
%   - Representation TFR via le Spectrogramme et WVD de Matlab
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc;

%%
% Signal x
fe = 1000; % Frequence d'echantillonnage 1000
f1 = 50;  
f2 = 100;   
duree  = 1; % Durée des signaux x1 et x2
tmp_N  = round(fe*duree);
tmp_t  = (0:tmp_N-1)./fe;
tmp_x1 = cos(2*pi*f1*tmp_t);
tmp_x2 = cos(2*pi*f2*tmp_t);

x  = [tmp_x1, tmp_x1 + tmp_x2, tmp_x2];
N  = length(x);     % Nbre d'echantillons en Temps
t  = (0:N-1)./fe;   % Echelle des temps du signal x

% Affichage Signal temps
figure;
subplot(221); 
hold on; grid on; 
plot(t, x, 'r'); xlabel(' signal x');

%% FFT
Nfft = N; % Nbre d'echantillons en fréquence
fftx = fftshift(fft(x,Nfft)./N);
freq = -fe/2:fe/Nfft:fe/2-fe/Nfft;
%freq = linspace(-fe/2,fe/2,Nfft);

% Affichage Signal fréquence
subplot(222);
hold on; grid on;
plot(freq, abs(fftx), 'r');
xlabel(' Spectre x');

%% Estimation des FI et AI du signal via Hilbert
SignalAnalytique = hilbert(x);

% FFT du signal analytique
Nfft          = N; % Nbre d'echantillons en fréquence
fftAnalytique = fftshift(fft(SignalAnalytique,Nfft)./N);
freq          = -fe/2 : fe/Nfft : fe/2-fe/Nfft;
%freq = linspace(-fe/2,fe/2,length(fftAnalytique));

% Estimation AI via signal analytique
AIest = abs(SignalAnalytique); % Estimation de AI

% Estimation FI signal analytique
FIest     = diff(angle(SignalAnalytique))*(fe/(2*pi)); % Estimation de FI
FIestfilt = medfilt1(FIest, 3);    % Estimation de FI avec un filtrage median de taille 3

figure; 
subplot(221); 
hold on; grid on; 
plot(t, x, '.r-'); xlabel(' Signal x et AI via Signal Analytique');
plot(t, AIest, 'b');

subplot(222);
hold on; grid on; 
plot(real(SignalAnalytique), imag(SignalAnalytique), '-b.');
xlabel(' Signal analytique : Représentation complexe');

subplot(223);
hold on; grid on; 
plot(freq, abs(fftAnalytique), '-b.');
xlabel(' Signal analytique : Spectre d''amplitude');

subplot(224);
hold on; grid on;
plot(t(1:length(FIest)), FIest, 'b');
plot(t(1:length(FIestfilt)), FIestfilt, '-r.');
xlabel(' FI via Signal Analytique (avant et apres filtrage)');

% Autre approche
figure; instfreq(x, fe, 'Method', 'hilbert')

% Ou encore 
[p,f,t] = pspectrum(x,fe,'spectrogram');
figure; instfreq(p,f,t)

%% TFR avec deux methodes de Matlab
nfft     = 512;
win      = hann(nfft); 
noverlap = ceil(nfft/3);
figure; hold on; grid on;
specgram(x,nfft,fe,win,noverlap);
xlabel('Temps'); ylabel('Fréquence (Hz)'); 
axis([0.08 2.81 0 round(fe/2)]);  

[TFR,ftfr,ttfr] = spectrogram(x,win,noverlap,nfft,fe,'yaxis');
figure; hold on; grid on;
imagesc(ttfr,ftfr,10*log10(abs(TFR)));          % affichage en log
xlabel('Temps'); ylabel('Fréquence (Hz)');
axis xy; axis tight; colormap(jet);

% Wigner Ville
figure; wvd(x, fe);

% Smoothed Pseudo Wigner-Ville distribution
figure; wvd(x,fe,'smoothedPseudo');
