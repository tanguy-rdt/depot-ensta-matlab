[x, fe]=audioread('glockenspiel.wav')

N=length(x);
t=0:1:N-1;
t=t./fe
T=t(end) % durée total du signal --> récupère le dernier échantillon



sound(x, fe)

Nfft=N*10; 
X = fft(x, Nfft);% spectre [0 fe]
X_centre = fftshift(X);
freq_X = linspace (-fe/2, fe/2, Nfft);


figure;
subplot(211);
plot(t, x, 'r');
subplot(212)
stem(freq_X, abs(X_centre), 'r'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
title('spectre entre -fe/2 et fe/2');
grid on;




r=10
sr=x(1:r:end) % pour faire x mais un échantillon sur deux
fer=fe/r
sound(sr, fer) % on à moins d'échantillon donc on fait pareil pour fe

Nfft=(N/r)*10; 
SR = fft(sr, Nfft);% spectre [0 fe]
SR_centre = fftshift(SR);
freq_SR = linspace (-fer/2, fer/2, Nfft);

figure;
stem(freq_SR, abs(SR_centre), 'r'); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
title('spectre entre -fe/2 et fe/2');
grid on;



