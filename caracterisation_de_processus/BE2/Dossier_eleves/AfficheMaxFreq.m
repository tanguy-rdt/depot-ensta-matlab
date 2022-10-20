function [Frequence, Amplitude]=AfficheMaxFreq(fftsig, freq, NbMax)
%%
% Code permettant de d�tecter un ou plusieurs max (NbMax) sur le signal fftsig
% et d'en d�duire la fr�quence associ�e
% fftsig: le spectre sur lequel on souhaite trouver les max entre [-fe/2 ,fe/2]
% freq  : l'echelle des fr�quences associ�es
% NbMax : Le nombre de max � trouver dans le signal
% Utilise la fonction pickpeak() 
%%
N        = length(fftsig);
freqPick = freq(round(N/2)+1:end);
fftPick  = abs(fftsig(round(N/2)+1:end));
[loc, val] = pickpeak(fftPick ,NbMax, 1);

if min(loc)>0
    Frequence  = freqPick(loc);
    Amplitude  = val;
    disp([' Fr�quences :',num2str(Frequence),' Hz.']);
else 
    disp([' Probleme de detection : ', num2str(loc')]);
    Frequence = 0;
    Amplitude = 0;
end 
