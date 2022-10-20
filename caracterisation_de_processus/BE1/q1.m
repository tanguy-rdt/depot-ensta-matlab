close all; clear all

%% question1
%%  Code TP signaux alÈatoires FIPA SE - question 1
% Auteur : I. Quidu, ENSTA Bretagne
% Date : 20/06/22

close all; clear all;

m = 0;
sigma = 0.1:0.1:1; 
N = 10000;
% fe = 1; % par dÈfaut
for ii = 1:length(sigma)
    b =  m+sigma(ii)*randn(N,1) ; % bruit blanc gaussien selon N(m,sigma(ii)^2)
    
    % distribution expÈrimentale
    [ef,x] = hist(b,100); % x indique le centre des classes de l'histogramme
    dx = x(2)-x(1); % largeur d'un intervalle
    % distribution thÈorique (sera superposÈe en trait rouge continu ‡ la distribution expÈrimentale)
    y = normpdf(x,m,sigma(ii));
    
    
    % Calcul de l'autocorrÈlation
    [autocorr,refx] = xcorr(b);
    autocorr = autocorr/length(b);
    maxA = max(autocorr)
    
    %
    figure;
    subplot(311), plot(b,'*'), ylabel('bruit'), xlabel('Èchantillons temporels'), axis([1 N -4 4]);
    subplot(312), bar(x,ef/sum(ef)/dx,'m'), xlabel('b'), ylabel('densitÈ de probabilitÈ');
    hold on;
    plot(x,y,'r');
    subplot(313), plot(refx,autocorr), ylabel('autocorrÈlation'), xlabel('Èchantillons temporels'), axis([-(N-1) N-1 0 1.2]);
end

% l'histogramme normalisÈ est une approximation de la densitÈ de probabilitÈ, soit une cloche centrÈe en m
% pour l'autocorr, on retrouve bien un pic en zÈro et des valeurs trËs faibles de part et d'autre, ce qui indique que les Èchantillons sont dÈcorrÈlÈs entre eux, 
% et l'amplitude du pic est bien Ègale ‡ sigma(ii)^2 (valeur maxA renvoyÈe)


%%
%%question 2 
fe = 8000 ; % Fréquence d'échantilonnage
fs = 250; % Fréquence de la sinusoïde
a = 1; % Amplitude de la sinusoïde
T = (1/fs)*10 % durée du signal 10 période
N = round(T*fe) % Nombre d'échantillon
t=0:1:N-1 % vecteur temps
t = t./fe %vecteur temps réel
s = a * sin(2*pi*fs*t) ; % vecteur signal synthétisé

N = length(s);
Nfft= 10 * N; 

S = fft(s, Nfft);% spectre en [0 fe]
S_centre = fftshift(S); % spectre en [fe/2 fe/2]
freq_S = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

% question 3
b = m+sigma(1)*randn(length(s), 1);
s_bruit = s + b;

S_bruit = fft(s_bruit, Nfft);% spectre en [0 fe]
S_centre_bruit = fftshift(S_bruit); % spectre en [fe/2 fe/2]
freq_S_bruit = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

figure;
subplot(4, 1, 1);
plot(t, s, 'k');  % répartition des échantillons de b
subplot(4, 1, 2), ylabel('Amplitude'), xlabel('Temps');
stem(freq_S, abs(S_centre), '*k'), ylabel('freq'), xlabel('spectre d''amplitude');  % répartition des échantillons de b
subplot(4, 1, 3);
plot(t, s_bruit, '*k'), ylabel('signal bruité'), xlabel('temps');  % répartition des échantillons de b
subplot(4, 1, 4);
semilogy(freq_S_bruit, abs(S_centre_bruit), 'k'), ylabel('freq'), xlabel('spectre d''amplitude');  % répartition des échantillons de b

%%
%%question 4
fe = 8000 ; % Fréquence d'échantilonnage
fs = 250; % Fréquence de la sinusoïde
a = 1; % Amplitude de la sinusoïde
T = (1/fs)*10 % durée du signal 10 période
N = round(T*fe) % Nombre d'échantillon
t=0:1:N-1 % vecteur temps
t = t./fe %vecteur temps réel
s = a * sin(2*pi*fs*t) ; % vecteur signal synthétisé

N = length(s);
Nfft= 10 * N; 

S = fft(s, Nfft);% spectre en [0 fe]
S_centre = fftshift(S); % spectre en [fe/2 fe/2]
freq_S = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]


for i = 1:length(sigma)
    b = m+sigma(i)*randn(length(s), 1);
    s_bruit = s + b;

    S_bruit = fft(s_bruit, Nfft);% spectre en [0 fe]
    S_centre_bruit = fftshift(S_bruit); % spectre en [fe/2 fe/2]
    freq_S_bruit = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

    figure;
    subplot(4, 1, 1);
    plot(t, s, 'k');  % répartition des échantillons de b
    subplot(4, 1, 2), ylabel('Amplitude'), xlabel('Temps');
    stem(freq_S, abs(S_centre), '*k'), ylabel('freq'), xlabel('spectre d''amplitude');  % répartition des échantillons de b
    subplot(4, 1, 3);
    plot(t, s_bruit, '*k'), ylabel('signal bruité'), xlabel('temps');  % répartition des échantillons de b
    subplot(4, 1, 4);
    stem(freq_S_bruit, abs(S_centre_bruit), 'k'), ylabel('freq'), xlabel('spectre d''amplitude');  % répartition des échantillons de b
    
    pause(2)
    close;
end





    
