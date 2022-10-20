function Px = Periodogram(x)
%% Estimation du périodogram simple
% x: le signal temporel
%% Completer le code ci-dessous :
N  = length(x) ; % Nombre d'echantillons en fréquence (identique au Nbre de pts en temps)
Y  = fft(x, N); % Spectre du signal
Y = fftshift(Y); % spectre en [fe/2 fe/2]
Px = (abs(Y).^2)./N; % Estimation de Gamma_xx(f)
