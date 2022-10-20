function Px = Periodogram_Moi(x)
% x   : le signal temporel
N  = length(x); % Nombre d'echantillons en fréquence (identique au Nbre de pts en temps) 
Y  = fft(x, N); 
Px = (abs(Y).^2 )./N; %% Ou Px = (Y.*conj(Y) )./N;
