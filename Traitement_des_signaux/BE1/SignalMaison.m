function [x,triangle,porte] = SignalMaison(N, taille, A1, A2)
%% Avec
%%  N : le nombre de points du signal x.
%% 	taille : la largeur du signal porte + triangle. doit etre une puissance
%% 	de 2 (division par 2 qui doit etre un entier)
%% 	A1 : l’amplitude du signal porte.
%%  A2 : l’amplitude du signal triangle.
%%  X : le signal : somme du triangle et de la porte
%%  porte : le signal porte seul.
%%  triangle : le signal triangle seul.

% creation signal porte
porte = zeros(1,N);
porte(220:220+taille+1) = 1; 

% creation signal triangle
triangle = zeros(1,N);
triangle(220:220+taille/2) = (1:1:taille/2+1)./(taille/2+1);
triangle(220+taille/2+1:220+taille+1) = (taille/2+1:-1:1)./(taille/2+1);

% signal total
x = A1.*triangle + A2.*porte;
