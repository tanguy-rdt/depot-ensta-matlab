function Px = Bart(x, K)
%% Estimation spectrale par Bartlett
% x : le signal temporel
% K : Nombre de segments (bloc)
%% Completer le code ci-dessous :
N  = length(x);  % Nombre de pts du signal
L  = floor(N/K);  % Nombre de pts par blok (c'est un entier) 

disp(['Bart - Nombre de segments : ', num2str(K)]);
disp(['Bart - Nombre de points par segment: ', num2str(L)]);
disp(['Bart - Nombre de points non traité: ', num2str(N), '-', num2str(L*K),':', num2str(N-L*K)]);

Px = 0;           % initialisation de Gamma_xx(f)
indice_debut = 1; % initialisation de l'indice de debut du premier bloc
indice_fin   = L; % initialisation de l'indice de fin du premier bloc
for i=1:K; % Pour les K blocs :
    
    bloc_signal = x(indice_debut:indice_fin); % Extraction du signal associé au bloc 
	
    Px = Px + Periodogram_Moi(x)./K; % Estimation de Gamma_xx(f)
    
	indice_debut = indice_debut + L; % nouveau indice de debut pour le bloc suivant
    indice_fin   = indice_debut + L - 1; % nouveau indice de fin   pour le bloc suivant
    
end;