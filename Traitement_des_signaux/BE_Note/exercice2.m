fe=1 %Hz
N=512
t= % vecteur temporelle t indice
t=t./fe % vecteur temporelle t réel



%% question 1
figure;
subplot(211);
plot(t, x1); 
xlabel('temps');
ylabel('amplitude');
legend('x1');
grid on;
subplot(212);
plot(t, x2); 
xlabel('temps');
ylabel('amplitude');
legend('x2');
grid on;





%% question 2
y1=
z1=
z2=

tz=%2 fois plus grand normalement
tz=tz./fe % vecteur temporelle tz réel

figure;
subplot(311);
plot(t, y1); 
xlabel('temps');
ylabel('amplitude');
legend('y1');
grid on;
subplot(312);
plot(tz, z1); 
xlabel('temps');
ylabel('amplitude');
legend('z1');
subplot(313);
plot(tz, z2);
xlabel('temps');
ylabel('amplitude');
legend('z2');
grid on;



%% question 3
Nfft=10*N; 

Y1 = fft(y1, Nfft);% spectre en [0 fe]
Y1_centre = fftshift(Y1); % spectre en [fe/2 fe/2]
freq_Y1 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

Z1 = fft(z1, Nfft);% spectre [0 fe]
Z1_centre = fftshift(Z1); % spectre en [fe/2 fe/2]
freq_Z1 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

Z2 = fft(z2, Nfft);% spectre [0 fe]
Z2_centre = fftshift(Z2); % spectre en [fe/2 fe/2]
freq_Z2 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

figure;
subplot(311);
stem(freq_Y1, abs(Y1_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('Y1')
grid on;
subplot(312);
stem(freq_Z1, abs(Z1_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('Z1')
grid on;
subplot(313);
stem(freq_Z2, abs(Z2_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('Z2')
grid on;



%% question 4
% Les spectres en amplitudes des signaux y1, z1 et z2 semble similaire.
% Après avoir effectuer un zoom on constate des sinus cardinaux au même
% fréquence et borné en fréquence et amplitude au même valeurs.


%% question 5



%% question 6


%% question bonus









