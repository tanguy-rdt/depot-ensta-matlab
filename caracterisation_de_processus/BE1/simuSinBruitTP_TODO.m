%%  Code � trous (r�p�r�s par les TODO) pour TP signaux al�atoires FIPA SE
% Auteur : I. Quidu, ENSTA Bretagne
% Date : 25/01/21

close all; clear all
%%	Synth�tiser un signal sinuso�dal s
fe = 8000 ; % Fr�quence d'�chantilonnage
fs = 250; % Fr�quence de la sinuso�de
a = 1; % Amplitude de la sinuso�de
temps = (1/fs)*10 ; % vecteur temps pour 10 p�riodes affich�es
s = a * sin(2*pi*fs) ; % vecteur signal synth�tis�
Lfft = 2^nextpow2(length(s)); % nombre de points sur laquelle faire la FFT
S = TODO; % TF du signal sur [-fe/2; fe/2]
fq = (-Lfft/2:Lfft/2-1)/Lfft*fe; % axe fr�quentiel de la FFT
figure(1), subplot(512),plot(fq,abs(S)), title('module de TF du signal sinuso�dal'),...
    xlabel('f (Hz)') , grid on % en normalisant par length(s) (= 10/fs*fe+1), on a l'amplitude du sinus non tronqu�
figure(1), subplot(511), plot(temps, s), title('signal utile sinuso�dal'),...
    xlabel('t (s)')
grid on, hold on, axis([min(temps) max(temps) -a*2 a*2])
pause % pour maximiser la taille de fen�tre

%%   Ajouter un bruit b gaussien
m = 0; % moyenne (bruit blanc est toujours centr�)
sigma = 0.1:0.1:1; % vecteur �cart-type
rsb_s_b = zeros(size(sigma)); % initialisation du vecteur RSB
for ii = 1:length(sigma) % boucle pour diff�rents �carts-types
    b = ii*randn(1,length(s)) ; % vecteur bruit de m�me longueur que s
    Pb =  ; % puissance statistique moyenne du bruit = E{b�(n)}
    [eff, val] = TODO; % histogramme sur 100 intervalles
    figure(1),
    subplot(513), plot(temps,b,'-k*'),...
        title(['bruit N(' num2str(m) ',' num2str(sigma(ii)) ')']),...
        xlabel('t (s)')
    grid on, hold on, axis([min(temps) max(temps) -a*2 a*2])
    ovb = ones(1,length(b)); % droite pour visualiser les niveaux de bruit
    plot(temps,m*ovb,'r');
    plot(temps,(m+sigma(ii))*ovb,'m');
    plot(temps,(m-sigma(ii))*ovb,'m');
    hold off
  
    % RSB
    Ps = TODO; %  puissance moyenne de la sinuso�de d'amplitude a
    rsb_s_b(ii) = TODO; % RSB en dB
    sb = TODO; % vecteur signal bruit�
    dm = ones(1,length(sb))*m; % droite pour visualiser les niveaux de signal bruit�
    ds = ones(1,length(sb))*(m+sigma(ii));
    dms = ones(1,length(sb))*(m-sigma(ii));
    figure(1), subplot(514), plot(temps, sb),...
        title(['signal bruit� - RSB = ' num2str(rsb_s_b(ii)) ' dB']), xlabel('t (s)')
    grid on, hold on, axis([min(temps) max(temps) -a*2 a*2])
    plot(temps,dm,'k')
    plot(temps,ds,'--k')
    plot(temps,dms,'--k')
    hold off
    
    % Visualiser le spectre d'amplitude
    Sf = TODO; % TF du signal bruit� sur [-fe/2; fe/2]
    % remarque : la division par le nb d'�ch ne devrait concerner que la partie du spectre du signal utile (sinusoide). Ce faisant, on minimise les fluctuations des composantes spectrales du bruit.
    figure(1), subplot(515), semilogy(fq,abs(Sf)),...
        title('module de TF du signal bruit� (dB)'), xlabel('f (Hz)')
    grid on, hold off

    pause(2)
end


