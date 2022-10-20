close all; clearvars; clc;

%% charger le signal
load('Data.mat');

N=length(x1);
t=0:1:N-1;
t=t./fe
T=t(end) % durée total du signal --> récupère le dernier échantillon

moyenne = mean(x1);
vect_mean=moyenne.*ones(1, N);

%Afficher le signal en temps QUESTION 1a
figure; hold on; grid on; 
plot(t, x1, 'r');
plot(t, vect_mean, 'g');
xlabel ('Temps');
ylabel ('Amplitude');
xlim([0 .01]) %permet de faire un zooom sur le signal sans le modifier
% Conclusion on ne peut rien tirer de l'annalyse temporelle, on commence donc
% l'annalyse freq






% Annalyse spectral QUESTION 1b
Nfft=N; 
X = fft(x1, Nfft);% spectre [0 fe]
X_centre = fftshift(X);
freq_X = linspace (-fe/2, fe/2, Nfft);

X0_centre = fftshift(X); % spectre [-fe/2 fe/2] avec ici fe = 1 
freq_X0 = linspace (-1/2, 1/2, Nfft);

X1 = fft(x1, Nfft);% spectre [0 fe]
freq_X1 = linspace (0, fe, Nfft);

figure;
%plot(freq, abs(X));
subplot(221);
stem(freq_X, abs(X_centre), 'r'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
title('spectre entre -fe/2 et fe/2');
grid on;
subplot(222);
stem(freq_X0, abs(X0_centre), 'r'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
title('spectre entre -1/2 et 1/2');
grid on;
subplot(223);
stem(freq_X1, abs(X1), 'r'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
title('spectre entre 0 et fe');
grid on;


% Analyse de la moyenne du signal
%QUESTION b
x2=x1-mean(x1);
x2Moy=mean(x2);
x2_mean=x2Moy.*ones(1, N); % Permet de passer x2 moy en vecteur


figure;
plot(t, x2, 'r');
xlabel ('Temps');
ylabel ('Amplitude');
legend('x2(t)');
grid on;

figure;
plot(t, x2_mean, 'g');
xlabel ('Temps');
ylabel ('Amplitude');
legend('x2_mean(t)');
grid on;


X2 = fft(x2, Nfft);% spectre [0 fe]
X2_centre = fftshift(X2); % spectre en [-fe/2 fe/2]
freq_X2 = linspace (-fe/2, fe/2, Nfft); % on centre le spectre en [-fe/2 fe/2]

figure;
stem(freq_X2, abs(X2_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
grid on;

figure;
stem(freq_X2, abs(X2_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
xlim([385 590])
grid on;

res=T/N

N_note=N/8;
T_note=T/8;
t_note=0:1:N_note-1;
t_note=t_note./fe;

Nfft=N_note; 

for i = 0:7
    
    x_bloc=x2(1+(N_note*i):1:N_note*(i+1))
    figure; hold on; grid on; 
    plot(t_note, x_bloc, 'r');
    
    X_bloc = fft(x_bloc, Nfft);% spectre [0 fe]
    X_bloc_centre = fftshift(X_bloc);
    freq_X_bloc = linspace (-fe/2, fe/2, Nfft);
    
    figure;
    stem(freq_X_bloc, abs(X_bloc_centre)); % plus visuel comme c'est des dirac
    title(i);
    xlabel('frequence');
    ylabel('spectre d''amplitude');
    grid on;
    
end

A=440 %la
B=493.8 %si
C=523.2 %do 
D=587.3%ré
G=391.9%sol

f_liste=[391.99; 440; 493.88; 391.99;  493.88; 523.25; 587.32; 587.32]
          %sol    la   si      sol       si     do       ré      ré
          

comptine=[];

for k=1:8
    comptine=[comptine cos(2*pi*f_liste(k)*t_note)]
end

%sound(comptine, fe);

spectrogram(x2,400,300,[],fe,'yaxis');








