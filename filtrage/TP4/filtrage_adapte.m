%%  Code à compléter (et modifier) pour la visualisation des signaux du TP filtrage adapté des FIPA SE
% Auteur : I. Quidu, ENSTA Bretagne
% Date : 25/01/21

close all; clear all;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% question 1
%--------------------------------------------------------------
% Echantillonnnage
%-----------------
Fe   = 100e6;
Te   = 1/Fe;

% Durée du signal émis
%----------------------
T    = 1300e-9;

% Durée totale d'observation
%---------------------------
Tmax  = 10e-6;
t_obs = [0:Te:Tmax];
N     = length(t_obs);

% Paramètres des cibles
%--------------------------

% cible1 (vitesse)
vitesse1 = 0;

% paramètres du signal reçu après réflexion sur la cible 1 (amplitude, retard)
a1       = 0.5;
retard1  = 4e-6;

% cible2 (vitesse)
vitesse2 = 0;

% paramètres du signal reçu après réflexion sur la cible 2 (amplitude, retard)
a2       = 0.45;
retard2  = 8e-6;


% Bruit
%---------
b=0;
% b=sigma*randn(1,N); % bruit gaussien d'écart-type = sigma

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Premier cas signal : signal monochromatique (à fréquence pure)
%---------------------------------------------------------------

f  = 5e6;

f1 = f + 2*vitesse1*f/3e8 ; % effet doppler dû à la vitesse
f2 = f + 2*vitesse2*f/3e8 ;

s1 = zeros(1,N);
s1(1:1+T/Te) = cos(2*pi*f*t_obs(1:1+T/Te));

s1r = zeros(1,N);
s1r(retard1/Te:retard1/Te+T/Te) = a1 * cos(2*pi*f1*t_obs(1:1+T/Te));
s1r(retard2/Te:retard2/Te+T/Te) = a2 * cos(2*pi*f2*t_obs(1:1+T/Te));
s1r = s1r+b;

%Filtrage adapté
%----------------
h1   = fliplr(s1(1:1+T/Te));
y1a  = filter(h1,1,s1);
yr1a = filter(h1,1,s1r);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Deuxième cas : chirp (signal modulé linéairement en fréquence)
%--------------------------------------------------------------

f  = 5e6 * t_obs(1:1+T/Te)/t_obs(1+T/Te);

f1 = f + 2*vitesse1*f/3e8; % effet doppler dû à la vitesse
f2 = f + 2*vitesse2*f/3e8;

s2 = zeros(1,N);
s2(1:1+T/Te) = cos(2*pi*f.*t_obs(1:1+T/Te));

s2r = zeros(1,N);
s2r(retard1/Te:retard1/Te+T/Te) = a1 * cos(2*pi*f1.*t_obs(1:1+T/Te));
s2r(retard2/Te:retard2/Te+T/Te) = a2 * cos(2*pi*f2.*t_obs(1:1+T/Te));
s2r = s2r+b;

%Filtrage adapté
%---------------
h2   = fliplr(s2(1:1+T/Te));
y2a  = filter(h2,1,s2);
yr2a = filter(h2,1,s2r);







%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% question 2
%--------------------------------------------------------------
figure, 
subplot(4, 1, 1); plot(t_obs, s1,'r'); hold on; plot(t_obs, s1r,'b'); legend('s1', 's1r');
subplot(4, 1, 2); plot(t_obs, s2,'r'); hold on; plot(t_obs, s2r,'b'); legend('s2', 's2r');
subplot(4, 1, 3); plot(t_obs, y1a,'r'); hold on; plot(t_obs, yr1a,'b'); legend('y1a', 'yr1a');
subplot(4, 1, 4); plot(t_obs, y2a,'r'); hold on; plot(t_obs, yr2a,'b'); legend('y2a', 'yr2a');
xlabel('t (s)'); ylabel('u');





%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% question 3
%--------------------------------------------------------------






%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% question 4
%--------------------------------------------------------------
retard1  = 1e-6;
retard2  = 5e-6;

%Premier cas signal : signal monochromatique (à fréquence pure)
f  = 5e6;

f1 = f + 2*vitesse1*f/3e8 ;
f2 = f + 2*vitesse2*f/3e8 ;

s1 = zeros(1,N);
s1(1:1+T/Te) = cos(2*pi*f*t_obs(1:1+T/Te));

s1r = zeros(1,N);
s1r(retard1/Te:retard1/Te+T/Te) = a1 * cos(2*pi*f1*t_obs(1:1+T/Te));
s1r(retard2/Te:retard2/Te+T/Te) = a2 * cos(2*pi*f2*t_obs(1:1+T/Te));
s1r = s1r+b;

h1   = fliplr(s1(1:1+T/Te));
y1a  = filter(h1,1,s1);
yr1a = filter(h1,1,s1r);


%Deuxième cas : chirp (signal modulé linéairement en fréquence)
f  = 5e6 * t_obs(1:1+T/Te)/t_obs(1+T/Te);

f1 = f + 2*vitesse1*f/3e8; 
f2 = f + 2*vitesse2*f/3e8;

s2 = zeros(1,N);
s2(1:1+T/Te) = cos(2*pi*f.*t_obs(1:1+T/Te));

s2r = zeros(1,N);
s2r(retard1/Te:retard1/Te+T/Te) = a1 * cos(2*pi*f1.*t_obs(1:1+T/Te));
s2r(retard2/Te:retard2/Te+T/Te) = a2 * cos(2*pi*f2.*t_obs(1:1+T/Te));
s2r = s2r+b;

h2   = fliplr(s2(1:1+T/Te));
y2a  = filter(h2,1,s2);
yr2a = filter(h2,1,s2r);


% FIGURE
figure, 
subplot(4, 1, 1); plot(t_obs, s1,'r'); hold on; plot(t_obs, s1r,'b'); legend('s1', 's1r');
subplot(4, 1, 2); plot(t_obs, s2,'r'); hold on; plot(t_obs, s2r,'b'); legend('s2', 's2r');
subplot(4, 1, 3); plot(t_obs, y1a,'r'); hold on; plot(t_obs, yr1a,'b'); legend('y1a', 'yr1a');
subplot(4, 1, 4); plot(t_obs, y2a,'r'); hold on; plot(t_obs, yr2a,'b'); legend('y2a', 'yr2a');
xlabel('t (s)'); ylabel('u');




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% question 5
%--------------------------------------------------------------
retard1  = 4e-6;
retard2  = 8e-6;

% Bruit
%---------
sigma = 0.5;
b=sigma*randn(1,N); % bruit gaussien d'écart-type = sigma

%Premier cas signal : signal monochromatique (à fréquence pure)
f  = 5e6;

f1 = f + 2*vitesse1*f/3e8 ; % effet doppler dû à la vitesse
f2 = f + 2*vitesse2*f/3e8 ;

s1 = zeros(1,N);
s1(1:1+T/Te) = cos(2*pi*f*t_obs(1:1+T/Te));

s1r = zeros(1,N);
s1r(retard1/Te:retard1/Te+T/Te) = a1 * cos(2*pi*f1*t_obs(1:1+T/Te));
s1r(retard2/Te:retard2/Te+T/Te) = a2 * cos(2*pi*f2*t_obs(1:1+T/Te));
s1r = s1r+b;

h1   = fliplr(s1(1:1+T/Te));
y1a  = filter(h1,1,s1);
yr1a = filter(h1,1,s1r);


%Deuxième cas : chirp (signal modulé linéairement en fréquence)
f  = 5e6 * t_obs(1:1+T/Te)/t_obs(1+T/Te);

f1 = f + 2*vitesse1*f/3e8; 
f2 = f + 2*vitesse2*f/3e8;

s2 = zeros(1,N);
s2(1:1+T/Te) = cos(2*pi*f.*t_obs(1:1+T/Te));

s2r = zeros(1,N);
s2r(retard1/Te:retard1/Te+T/Te) = a1 * cos(2*pi*f1.*t_obs(1:1+T/Te));
s2r(retard2/Te:retard2/Te+T/Te) = a2 * cos(2*pi*f2.*t_obs(1:1+T/Te));
s2r = s2r+b;

h2   = fliplr(s2(1:1+T/Te));
y2a  = filter(h2,1,s2);
yr2a = filter(h2,1,s2r);

figure, 
subplot(2, 2, 1); plot(t_obs, s1,'r');  hold on; plot(t_obs, s1r,'b');  legend('s1', 's1r');
subplot(2, 2, 2); plot(t_obs, s2,'r');  hold on; plot(t_obs, s2r,'b');  legend('s2', 's2r');
subplot(2, 2, 3); plot(t_obs, y1a,'r'); hold on; plot(t_obs, yr1a,'b'); legend('y1a', 'yr1a');
subplot(2, 2, 4); plot(t_obs, y2a,'r'); hold on; plot(t_obs, yr2a,'b'); legend('y2a', 'yr2a');
xlabel('t (s)'); ylabel('u');


RSB1 = yr1a/b;

%%


