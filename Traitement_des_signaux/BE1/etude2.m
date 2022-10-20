fe = 1; % Fréquence échantillonage Hz
A1 = 1; % Amplitude du signal
A2 = 1; % Amplitude du signal
N = 1048; %Nombres de points en temps. round permet d'avoir une approximation au plus proche
t=0:1:N-1; % vecteur indice
t=t./fe; % vecteur temporelle réel

[x,triangle,porte] = SignalMaison(N,512,1,1); 

f1 = 0.2;
Am1 = 2;
Cm1 = 0;

m1 = Am1*cos(2*pi*f1*t) + Cm1;
y = x.* m1;

Nfft=10*N; 
M1 = fft(m1, Nfft);% spectre [0 fe]
M1_centre = fftshift(M1);
freq_M1 = linspace (-fe/2, fe/2, Nfft);

Nfft=10*N; 
Y = fft(y, Nfft);% spectre [0 fe]
Y_centre = fftshift(X);
freq_Y = linspace (-fe/2, fe/2, Nfft);

Nfft=10*N; 
X = fft(x, Nfft);% spectre [0 fe]
X_centre = fftshift(X);
freq_X = linspace (-fe/2, fe/2, Nfft);



f2 = 0.15;
Am2 = 1;

m2 = Am2*cos(2*pi*f2*t);
z = y .* m2 ;

Nfft=10*N; 
Z = fft(z, Nfft);% spectre [0 fe]
Z_centre = fftshift(Z);
freq_Z = linspace (-fe/2, fe/2, Nfft);



figure; % no sé
plot(t, x, 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('temps , signal triangle + porte');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

figure; % no sé
plot(freq_X, X_centre, 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('frequence fft de triangle + porte');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

figure; % no sé
plot(t, y, 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('temps y = x et cos');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

figure; % no sé
plot(freq_Y, Y_centre, 'black'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('frequence fft y= x et cos');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

figure; % no sé
plot(t, m1, 'red'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('frequence cos');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

figure; % no sé
plot(freq_M1, M1_centre, 'black'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('frequence fft cos ');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille

figure; % no sé
plot(freq_Z, Z_centre, 'black'); % abs, ordo, couleur 'd-' : affiche les points
xlabel('frequence, modulation 2 ');% nom des abscisses
ylabel('Amplitude'); % nom des ordonnées
grid on; % trace la grille


