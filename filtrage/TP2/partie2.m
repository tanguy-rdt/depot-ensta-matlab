close all; clear all; clc;

%% Question 1 
fe = 8000 ;
H = ones(10,1)/10;
Tn = 23;
t = (0:Tn-1)/fe;
hn = filter(H, 1, [1; zeros(Tn-1,1)]); % [1; zeros(Tn-1,1)] = impulsion de Dirac
figure(1), plot(t, hn, '*'), title("Réponse impulsionelle de h(n)"); 
% C'est une porte, donc un filtre moyenneur.
% C'est un filtre RIF comme c'est un signal finis

%% Question 3: réponse harmonique en détaillant les opérations (fonctions MatLab fft, fftshift, abs et angle)
Lfft =  Tn; 		% à fixer : nbre de points de la fft
Hf = fft(hn, Lfft); % à compléter : FFT de hn sur Lfft points et décalage spectral pour avoir un spectre entre -fe/2 et fe/2
Hf = fftshift(Hf);
freq = -fe/2:fe/Hf:((fe/2)-(fe/Hf)); % fenêtre centré en [fe/2 fe/2]
Gf =  abs(Hf); % à compléter : module de Hf
Phif =  angle(Hf);	% à compléter :  phase de Hf
fq = (-Lfft/2:Lfft/2-1)/Lfft*fe;
figure(2), subplot(2,1,1), plot(fq,(Gf)), title('module de Hf'),...
xlabel('f (Hz)') 
grid on
subplot(2,1,2), plot(fq, (Phif)*180/pi), title('phase de Hf'),...
    xlabel('f (Hz)'), ylabel('deg')
grid on

%%	Question 5: Synthétiser un signal sinusoïdal s
fs = 250; % à fixer
temps= [0 : 1/fe : 10*(1/fs) ] ; % à compléter pour afficher 10 périodes affichées
s =  sin(2*pi*fs*temps); % à compléter : génération du vecteur signal
S = fftshift(fft(fs,Lfft )); % à compléter : FFT de s sur Lfft points et décalage spectral pour avoir un spectre entre -fe/2 et fe/2
figure(3), plot(fq,abs(S)/length(s)), title('module de Sf'),...
    xlabel('f (Hz)') , grid on % en normalisant par length(s) , on a l'amplitude du sinus non tronqué
figure(4), subplot(3,1,1), plot(temps, s), title('signal utile'),...
    xlabel('t (s)')
grid on
hold on

%%  Question 6:  Ajouter un bruit b gaussien
m = 0; % moyenne à choisir
sigma = 0.5; % écart-type à choisir
b = m+sigma*randn(1,length(temps)) ; % génération du vecteur bruit de même longueur que temps et s
figure(4),subplot(3,1,2), plot(temps, b,'r'),...
    title(['bruit N(' num2str(m) ',' num2str(sigma) ')']),...
    xlabel('t (s)')
grid on
hold off
sb = s + b; % % génération du vecteur signal bruité
figure(4), subplot(3,1,3), plot(temps, sb),...
    title('signal bruité'), xlabel('t (s)')
grid on

%% Question 6 : partie à exécuter pour comprendre le rôle de m et sigma
[eff, val] = hist(b,100);
figure(5), 
subplot(211), plot(b,'*'), xlabel('no échantillon'),ylabel('échantillon'), hold on
vb = 1:length(b);
ovb = ones(1,length(vb));
plot(vb,m*ovb,'r');
plot(vb,(m+sigma)*ovb,'m');
plot(vb,(m-sigma)*ovb,'m');
subplot(212), bar(val,eff), xlabel('valeur de la variable'),ylabel('effectif'),hold on
vm = m*ones(1,length(val));
[valm,indm] = min(abs(vm-val));
bar(val(indm),max(eff),'r','barwidth',0.025)
vs = (m+sigma)*ones(1,length(val));
[vals,inds] = min(abs(vs-val));
bar(val(inds),max(eff),'m','barwidth',0.025)
vs = (m-sigma)*ones(1,length(val));
[vals,inds] = min(abs(vs-val));
bar(val(inds),max(eff),'m','barwidth',0.025)

%%	Question 7 : Filtrer le signal utile s 
sf = conv(s, hn); % à compléter : filtrage de s => génération du vecteur signal filtré sf
figure(7),plot(temps, s(1:length(temps))),...
    title('signal d''entrée'), xlabel('t (s)')
grid on
hold on
plot(temps, sf(1:length(temps)),'r'),...
    title('comparaison de s (bleu) et sf (rouge)'), xlabel('t (s)')
attenuation = max(abs(sf))/max(abs(s))

%%	Question 7 : Filtrer le signal bruité sb = s + b afin de retrouver s
sf = conv(sb, hn); % à compléter : filtrage de sb => génération du nouveau vecteur signal filtré sf
figure(6),subplot(2,2,3), plot(temps, sf(1:length(temps)),'r'),...
    title('signal filtré'), xlabel('t (s)')
grid on
figure(6), subplot(2, 2, 1), plot(temps, sb), title('signal buité'), xlabel('t (s)'), ...
grid on

Pb = var(b)+(mean(b)^2) % puissance statistique moyenne du bruit

%% efficacité du filtrage pour différente puissances du bruit 
m = 0;
