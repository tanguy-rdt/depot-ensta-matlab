function [A, F, T] = TFCT(x, Fe)
% TFTC sans recouvrement avec configuration arbitraire
[ligne, colonne] = size(x);
if ligne ~= 1;
    x=x.'; % transposition du vecteur en ligne
end;
[ligne, colonne] = size(x);
n = colonne;
%% Cr�ation de la transform�e � court terme
nfft  = 128; %on fera le calcul de la fft sur nbfft points
Lbloc = round(length(x)./11);  %on va d�couper le signal en Lbloc de 10 points
freq  = [0:nfft/2-1]*Fe/nfft;  % cr�ation du vecteur fr�quence

nblocs = floor(n/Lbloc); %nombre de blocs

% on prend chaque bloc du signal
% on effectue la fft
% et on conserve le module de chaque bloc dans un vecteur A

A = [];
for k = 1:nblocs;
   xtronc = x((k-1)*Lbloc+1:k*Lbloc); % Extraction  du bloc sans recouvrement
   %xtronc=xtronc.*hamming(length(xtronc))'; % possible de mettre une
   %fenetre de pond�ration
   fftxtronc = abs(fft(xtronc',nfft));
   A = [A fftxtronc]; % concatenation des FFT des differents blocs
end
A = A(1:nfft/2,:);
F = freq;       % echelle frequentielle
T = [1:nblocs]; % nouvelle echelle temporelle