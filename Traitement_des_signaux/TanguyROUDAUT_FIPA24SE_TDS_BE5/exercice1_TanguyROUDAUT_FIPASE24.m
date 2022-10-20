% Tanguy ROUDAUT FIPASE24 - exercice 1

close all;

load('signalexo1.mat');

N=length(x);
t=0:1:N-1;
t=t./fe;
T1=t(end); % T1 comme T existe déjà comme vecteur visiblement

%% question 1
figure;
plot(t, x);
title('Question 1, signal temporelle');
xlabel('temps');
ylabel('amplitude');
legend('x');
grid on;

% caractéristiques temporelles :
% Le signal temporelle carrée est d'amplitude MAX: 4V et d'amplitude MIN:-4V
% La tension moyenne du signal est donc de 0V
% On dirait un signal carré bruité de durée finie 1,8s
%C'est un signal à puissance moy finie non null et à énergie infinie



%% question 2
Nfft=10*N; %zero padding de 10

X = fft(x, Nfft);% spectre en [0 fe]
X_centre = fftshift(X); % spectre en [fe/2 fe/2]
freq_X = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

figure;
plot(freq_X, abs(X_centre)); % plus visuel comme c'est des dirac
title('Question 2, spectre d''amplitude en [-fe/2 fe/2]')
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('X')
grid on;

% caractéristiques fréquentielle :
% La fréquence fondamentale est à 2Hz et l'harmonique 1 est à 80Hz
% C'est un spectre de raies le signal est donc périodique
% C'est un sinus cardinal, ce qui correspond à la TF d'une porte on peut
% donc dire que le signal temporelle est un signal carée 
% Composante null à f0



%% question 3

% on rappel les caractéristiques temporelles:
% Le signal temporelle carrée est d'amplitude MAX: 4V et d'amplitude MIN:-4V
% La tension moyenne du signal est donc de 0V
% On dirait un signal carré bruité de durée finie 1,8s
% C'est un signal à puissance moy finie non null et à énergie infinie


% caractéristiques fréquentielle :
% La fréquence fondamentale est à 2Hz et l'harmonique 1 est à 80Hz
% C'est un spectre de raies le signal est donc périodique
% C'est un sinus cardinal, ce qui correspond à la TF d'une porte on peut
% donc dire que le signal temporelle est un signal carée 
% Composante null à f0


%% question 4
x2 = Traitement(x);

Nfft=10*N; 

X2 = fft(x2, Nfft);% spectre en [0 fe]
X2_centre = fftshift(X2); % spectre en [fe/2 fe/2]
freq_X2 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

figure;
suptitle('Question 4')
subplot(211);
plot(t, x2);
xlabel('temps');
ylabel('amplitude');
legend('x2');
grid on;
subplot(212);
stem(freq_X2, abs(X2_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('X2')
grid on;

%Le fichier traitement.p permet de supprimer le bruit avec un filtre passe
%bas. Quand on observe le signal traité on se rend compte qu'il n'y à plus
%de bruit. Quand on observe le spectre en amplitude on se rend compte
%qu'il n'y a plus de raie spectrale à 80Hz. On peut conclure par que le
%fichier traitement permet de retirer le bruit avec un filtre passe bas.
% admettons que le fichier traitement correspond au systèmes définis par
% h(t) :
%
%                  _____________________
%                 |                     |
%      e(t) ------|         h(t)        |------ s(t)
%                 |_____________________|
%
% s(t)= e(t) [produit de convolution] h(t)
%
%   Le produit de convolution va donc décaler en temporelle, et
%   échantillonner en fréquentielle, c'est pour ça que notre spectre en
%   amplitude n'est pas décalé alors que le signal temporelle si.
%

%% question bonus

tx3 = linspace(0,1.7,512);
x3 = 2*square(2*pi*2*tx3)+randn(size(tx3));

figure;
title('Question bonus');
plot(tx3,x3);
xlabel('temps');
ylabel('Amplitude');
grid on

