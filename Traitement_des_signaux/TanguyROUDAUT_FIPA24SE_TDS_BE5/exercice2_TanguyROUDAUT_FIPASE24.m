% Tanguy ROUDAUT FIPASE24 - exercice 2

close all;

fe=1 %Hz
N=512 %nb echantillons
t=(0:N-1) % vecteur temporelle t indice
t=t./fe % vecteur temporelle t réel

f1=0.1 %Hz
f2=0.3 %Hz
x1=cos(2*pi*f1*t)
x2=cos(2*pi*f2*t)


%% question 1
figure;
suptitle('Question 1');
subplot(211);
plot(t, x1, '-k'); 
xlabel('temps');
ylabel('amplitude');
legend('x1');
grid on;
subplot(212);
plot(t, x2, '-m'); 
xlabel('temps');
ylabel('amplitude');
legend('x2');
grid on;






%% question 2
y1=x1+x2
z1=[x1 x2]
z2=[x2 x1]

tz=0:length(z1)-1 % vecteur temporelle tz indice
tz=tz./fe % vecteur temporelle tz réel

figure;
suptitle('Question 2');
subplot(311);
plot(t, y1); 
xlabel('temps');
ylabel('amplitude');
legend('y1');
grid on;
subplot(312);
plot(tz, z1, '-r'); 
xlabel('temps');
ylabel('amplitude');
legend('z1');
subplot(313);
plot(tz, z2, '-g');
xlabel('temps');
ylabel('amplitude');
legend('z2');
grid on;



%% question 3
Nfft=10*N; 

Y1 = fft(y1, Nfft);% spectre en [0 fe]
Y1_centre = fftshift(Y1); % spectre en [-fe/2 fe/2]
freq_Y1 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [-fe/2 fe/2]

Z1 = fft(z1, Nfft);% spectre [0 fe]
Z1_centre = fftshift(Z1); % spectre en [-fe/2 fe/2]
freq_Z1 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [-fe/2 fe/2]

Z2 = fft(z2, Nfft);% spectre [0 fe]
Z2_centre = fftshift(Z2); % spectre en [-fe/2 fe/2]
freq_Z2 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [-fe/2 fe/2]

figure;
suptitle('Question 3, (spectre d''amplitude centré en [-fe/2 fe/2])');
subplot(311);
stem(freq_Y1, abs(Y1_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('Y1')
grid on;
subplot(312);
stem(freq_Z1, abs(Z1_centre), '-r'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('Z1')
grid on;
subplot(313);
stem(freq_Z2, abs(Z2_centre), '-g'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('Z2')
grid on;



%% question 4
% Les spectres en amplitudes des signaux y1, z1 et z2 semble similaire.
% Après avoir effectuer un zoom et du zero padding on constate des sinus
% cardinaux aux mêmes fréquencex et amplitudes.
% Alors que les signaux temporelles sont bien différent en forme, en fréquence et
% également en temps pour y1 et z1/z2



%% question 5
% On peut donc en conclure que la TF n'est pas suffisante pour des signaux
% dont les caractéristiques en fréquences change au cours du temps. On le
% constate sur l'exemple précédent, signaux différent en temps, fréquence,
% forme... Mais même spectres en amplitudes.
% En regardant le uniquement le spectre en amplitude obtenu par TF il est
% impossible de savoir que les caractéristiques en fréquence du signal
% change. De plus on ne peut s'avoir à quel instant dans le temps on change
% de fréquences



%% question 6

[A, F, T] = TFCT(y1, fe);
figure;
surf(T, F, A); view(-60,30); shading interp
xlabel(' Temps'); ylabel(' Fréquence'); zlabel(' TFR Y1');
% On distingue correctement sur toutes la durées du dignal qu'il y a deux
% fréquences, une à 0.1Hz et une autre à 0.2Hz

[A, F, T] = TFCT(z1, fe);
figure;
surf(T, F, A); view(-60,30); shading interp
xlabel(' Temps'); ylabel(' Fréquence'); zlabel(' TFR Z1');
%On distingue sur la moitié du temps la fréquence 0.3Hz du signal x2 et la fréquence
% à 0.1Hz du signal x1 sur l'autre moitié du temps

[A, F, T] = TFCT(z2, fe);
figure;
surf(T, F, A); view(-60,30); shading interp
xlabel(' Temps'); ylabel(' Fréquence'); zlabel(' TFR Z2');
%On distingue sur la moitié du temps la fréquence 0.1Hz du signal x1 et la fréquence
% à 0.3Hz du signal x2 sur l'autre moitié du temps

%% question bonus
nfft = 128;

[B,F,T] = specgram(y1, nfft, fe, hamming(nfft), nfft/2); figure; % hamming, boxcar, hanning, bartlett, blackman
pcolor(T, F, 20*log10(abs(B))); shading interp; colorbar;

[B,F,T] = specgram(z1, nfft, fe, hamming(nfft), nfft/2); figure;
pcolor(T, F, 20*log10(abs(B))); shading interp; colorbar;

[B,F,T] = specgram(z2, nfft, fe, hamming(nfft), nfft/2); figure;
pcolor(T, F, 20*log10(abs(B))); shading interp; colorbar;











