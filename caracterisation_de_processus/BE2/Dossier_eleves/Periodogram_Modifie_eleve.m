function Px = Periodogram_Modifie(x, win)
%% Estimation du périodogram Modofié
% x   : le signal temporel
% win : entier entre [1 et 5] permettant de choisir la fenetre d'analyse
%% Completer le code ci-dessous :
N = length(x); % Nombre d'echantillons en fréquence (identique au Nbre de pts en temps)

% Parametre de la fenetre de longueur N
W = ones(N,1); % Initialisation de la fenetre d'analyse
if         (win == 0); W = ones(N, 1);  % Fenetre Rectangulaire (pas de fenetre)
    elseif (win == 1); W = triang(N);  % Fenetre triangle 
    elseif (win == 2); W = hamming(N); % Fenetre de hamming
	elseif (win == 3); W = hanning(N); % Fenetre de hanning
	elseif (win == 4); W = barlett(N); % Fenetre de bartlett
	elseif (win == 5); W = blackman(N);% Fenetre de blackman
end;

% Estimation de la DSP
U   = norm(W.')^2./N; % Coefficiant de normalisation associé à la fenetre
xw  = x.*W'; % Application de la fenetre W sur le signal x
Y   = fft(xw, N); % Spectre du signal xw
Y = fftshift(Y); % spectre en [fe/2 fe/2]
Px  = (abs(Y).^2)./(N*U); % Estimation de Gamma_xx(f)
