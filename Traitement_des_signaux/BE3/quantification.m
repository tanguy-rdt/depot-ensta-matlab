function [s_quantifie, q] = quantification(s, vmin, vmax, b)
%% Avec
%%  s : le signal
%% 	b : nb bits

N=2^b;%Nombre de niveau de quantification
D=vmax-vmin; %Dynamique du CAN
q=(D)/(N-1); %pas de quantification du CAN
Echelle_Possible=vmin:q:vmax; %Ensemble des valeurs possibles du CAN

N_s=length(s); %Nbr d'échantillons du signal
s_quantifie=zeros(1, N_s); %Initialisation signal quantifié


%Pour chaque échantillon de on cherche la valeurs la plus proche dans
%l'échelle du CAN
for k=1: N_s
    erreur = abs(s(k)-Echelle_Possible); %Erreur entre la mesure et l'échelle du CAN
    [val_min, indice_min]=min(erreur); %renvoie l'indice du vecteur v qui correspond à l'écart absolu minimal entre s(1) et toutes les composantes de v
    s_quantifie(k)=Echelle_Possible(indice_min); %Quantification de la mesure 
end

