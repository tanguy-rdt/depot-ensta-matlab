function Px = Welch(x, L, overlap, win)
%% Estimation spectrale par Welch
% x : le signal temporel
% L : nombre de points par bloc (c'est un entier)
% overlap : Taux (entre [0 1[) de recouvement entre deux blocs consécutifs 
%           si 0 pas de recouvrement dans ce cas D=L
% win : entier entre [1 et 5] permettant de choisir la fenetre d'analyse 
%
% Autres grandeurs importantes :
% D : Nombre de pts permettant le décalage entre deux séquences consécutives lors du recouvrement
%     (c'est un entier)
% K : Nombre de segments (c'est un entier)
% utilise : Periodogramme_Modifie
%% Completer le code ci-dessous :
if (overlap>=1) || (overlap < 0);
    error (' Overlap pas bon ! [0 1[');
end;

N = length(x);             % Nombre de pts du signal
D = floor((1-overlap)*L);  % Nombre de pts pour réaliser le Décalage
K = 1 + floor((N-L)/D);    % Nombre de segments (bloc)
disp(['Welch - Nombre de segments : ', num2str(K)]);
disp(['Welch - Nombre de point par segment : ', num2str(L)]);
disp(['Welch - Taux de recouvrement : ', num2str(overlap)]);
disp(['Welch - Nombre de point lors du recouvrement : ', num2str(L-D)]);

Px           = 0; % initialisation de Gamma_xx(f)
indice_debut = 1; % initialisation de l'indice de debut du premier bloc
indice_fin   = L; % initialisation de l'indice de fin du premier bloc
for i=1:K;% Pour les K blocs :
    
    bloc_signal = x(indice_debut:indice_fin); % Extraction du signal associé au bloc
    
    Px = Px + Periodogram_Modifie_Moi(bloc_signal, win)./K; % Estimation de Gamma_xx(f)
	
    indice_debut = indice_debut + D; % nouveau indice de debut du bloc suivant
    indice_fin   = indice_debut + L - 1; % nouveau indice de fin du bloc suivant
end;