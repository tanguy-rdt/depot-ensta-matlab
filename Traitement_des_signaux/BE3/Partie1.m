close all; clear all; clc

f0=1
T0=1/f0
fe_min=2*f0
fe=50*fe_min
T=10*T0
N = round(T*fe); %Nombres de points en temps. round permet d'avoir une approximation au plus proche
N0=round(T0*fe)
t=0:1:N-1; % vecteur indice
t=t./fe; % vecteur temporelle réel

s=5+5*sin(2*pi*t)


Nfft=N; 
S = fft(s, Nfft)/Nfft;% On divise par Nfft parce que on a fait une fft d'un signal finis et qu'on à 10 périodes
S_centre = fftshift(S);
freq_S = linspace (-fe/2, fe/2, Nfft);

figure; 
subplot(211);
plot(t, s, 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('temps');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille
subplot(212);
plot(freq_S, abs(S_centre), 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('frequence');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

%Quantification du signal
[sq, q]=quantification(s, 0, 10, 4);
erreur = sq-s;

%Affichage en temps
figure; hold on;
plot(t, s);
plot(t, sq);
plot(t, erreur);
legend('signal', 'signal quantifié', 'Erreur');
xlabel('Temps'); ylabel('Amplitudes');
grid on;

figure; 
h=histogram(erreur, 'Normalization', 'pdf');
get(h);

moyAmplHisto=mean(h.Values) 

%ce son les propriétés attendues comme la moyenne de l'amplitude de
%l'histogramme est de environ 1/q


%%
s=2*randn(size(t))


figure; hold on;
plot(t, s);
xlabel('Temps'); ylabel('Amplitudes');
grid on;

figure; 
h=histogram(s, 'Normalization', 'pdf');
get(h);

%Quantification du signal
[sq, q]=quantification(s, -10, 10, 4);
erreur = sq-s;

%Affichage en temps
figure; hold on;
plot(t, s);
plot(t, sq);
plot(t, erreur);
legend('signal', 'signal quantifié', 'Erreur');
xlabel('Temps'); ylabel('Amplitudes');
grid on;

figure; 
h=histogram(erreur, 'Normalization', 'pdf');
get(h);

moyAmplHisto=mean(h.Values) 
%ce son les propriétés attendues comme la moyenne de l'amplitude de
%l'histogramme donc de l'erreur de quantification est de environ 1/q et l'histogramme a la forme d'une porte


