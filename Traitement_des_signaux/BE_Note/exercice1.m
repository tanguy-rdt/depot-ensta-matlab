load(‘signalexo1.mat’);

N=length(x);
%t=0:1:N-1; si t commence à 0
t=t./fe
T=t(end) 

%% question 1
figure;
plot(t, x);
xlabel('temps');
ylabel('amplitude');
legend('x');
grid on;


%% question 2
Nfft=10*N; 

X = fft(x, Nfft);% spectre en [0 fe]
X_centre = fftshift(X); % spectre en [fe/2 fe/2]
freq_X = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

figure;
stem(freq_X, abs(X_centre)); % plus visuel comme c'est des dirac
xlabel('frequence');
ylabel('spectre d''amplitude');
legend('X')
grid on;


%% question 3



%% question 4
x2 = Traitement(x);

Nfft=10*N; 

X2 = fft(x2, Nfft);% spectre en [0 fe]
X2_centre = fftshift(X2); % spectre en [fe/2 fe/2]
freq_X2 = linspace (-fe/2, fe/2, Nfft); % fenêtre centré en [fe/2 fe/2]

figure;
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


%% question bonus




