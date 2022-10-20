fe = 512; % Fréquence échantillonage Hz
f0 = 128; % Fréquence du signal
A = 5; % Amplitude du signal
T = 1; % Durée du signal en secondes
N = round(T*fe); %Nombres de points en temps. round permet d'avoir une approximation au plus proche
t=0:1:N-1; % vecteur indice
t=t./fe; % vecteur temporelle réel
x = A * cos(2*pi*f0*t); % signal initial
%x = x.*window(@gausswin, length(x))'; %Pondération fenetre gaussienne
length(t) == N; % Si c'est égale à 1 c'est tout bon

figure; % no sé
plot(t, x, 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('temps');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

%spectre d'amplitude
Nfft=10*N; % On un nombre d'échantillon en freq et en temps, respecter le nom des différentes variables (il faut au moins 64 comme N)
X = fft(x, Nfft);% spectre [0 fe]
freq = linspace(0,fe,Nfft);

X_centre = fftshift(X); %spectre [-fe/2, fe/2]
freq_centre = linspace (-fe/2, fe/2, Nfft);%centrer le cadre

figure;
%plot(freq, abs(X));
subplot(121);
stem(freq, abs(X)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
grid on;
subplot(122);
stem(freq_centre, abs(X_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
grid on;

