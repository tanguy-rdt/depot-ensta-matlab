clear all; close all;
Fe2 = 10000; % Fr�q. d'�chantillonnage du syst�me de conversion analogique num�rique
Te2 = 1/Fe2; % P�riode d'�chantillonnage du syst�me de conversion analogique num�rique
fa = 3500; fb = 7000; % raies spectrales

%% simulation de la version continue du signal
fact = 10; 
Fe1 = fact*Fe2; % fr�quence d'�chantillonnage respectant (largement) shannon (Fe1 min = 2*fb =14000Hz) => signal qui semble continu
Te1 = 1/Fe1; % p�riode d'�chantillonnage
T  = 1;                  % Duree du signal en Temps [s] 
N  = round(T*Fe1);       % Nombre de points en temps
t1  = (0:N-1)/Fe1;       % Vecteur temps 
s1 =  sin(2*pi*fa*t1) + sin(2*pi*fb*t1); 
% figure(2), plot(t1,s1,'-*'), hold on, grid on
v1 = 1:length(t1)/100; % /100 pour n'afficher que les premi�res p�riodes 
figure(2), plot(t1(v1),s1(v1),'-*'), hold on, grid on
xlabel('temps (s)')

% Nfft1 = length(s1); % a minima mais pas une puissance de 2
Nfft1 = 2*2^nextpow2(length(s1)); % �chantillonnage fr�quentiel tr�s fin
% pour voir les sinc et r�cup�rer les bonnes amplitudes
f1 = -Fe1/2:Fe1/Nfft1:Fe1/2-Fe1/Nfft1;
S1 = abs(fftshift(fft(s1,Nfft1)))/length(s1);
figure(1), plot(f1,S1), hold on, grid on
xlabel('fr�quence (Hz)')
% on voit bien les deux raies � 3.5 et 7kHz d'amplitudes ~= 0.5


%question 7
t2 = t1(1:fact:end); % Nouveau vecteur temps (dur�e max = 1s)
s2 = s1(1:fact:end); % Nouveau vecteur signal

v2 = 1:length(t2)/100; % visu temporel de quelques p�riodes seulement pour plus de clart�
figure(2), plot(t2(v2),s2(v2),'r-*'),
legend('s1','s2','Fontsize',14)


%question 8
Nfft2 = 2*2^nextpow2(length(s2)); % �chantillonnage fr�quentiel tr�s fin
% pour voir les sinc et r�cup�rer les bonnes amplitudes
f2 = -Fe2/2:Fe2/Nfft2:Fe2/2-Fe2/Nfft2;
S2 = abs(fftshift(fft(s2,Nfft2)))/length(s2);
figure(1), plot(f2,S2), hold on, grid on
legend("s1", "s2")
xlabel('fr�quence (Hz)')

%question 9 10 11
fc=Fe2/2;
fcc=fc/Fe1*2;
n=10*fact; %1*fac %5*fac %10*fac
h=fir1(n, fcc);
figure, freqz(h, 1, Nfft1), title(['FAR avec ordre = ' num2str(n)]);
s1f=filter(h, 1, s1);
figure(2), plot(t1(v1), s1f(v1), 'k-*');
legend('s1', 's2', 's1f', 'Fontsize', 14);

%question 12 13
%v�rification spectrale
Nfft1 = 2^nextpow2(length(s1f)); % �chantillonnage fr�quentiel tr�s fin
% pour voir les sinc et r�cup�rer les bonnes amplitudes
f1 = -Fe1/2:Fe1/Nfft1:Fe1/2-Fe1/Nfft1;
S1f = abs(fftshift(fft(s1f,Nfft1)))/length(s1f);
figure(1), plot(f1,S1f, 'k'), hold on, grid on
xlabel('fr�quence (Hz)')
% on voit bien les deux raies � 3.5 et 7kHz d'amplitudes ~= 0.5


%question 14
t2 = t1(1:fact:end); % Nouveau vecteur temps (dur�e max = 1s)
s2f = s1f(1:fact:end); % Nouveau vecteur signal

v2 = 1:length(t2)/100; % visu temporel de quelques p�riodes seulement pour plus de clart�
figure(2), plot(t2(v2),s2f(v2),'m-*'),
legend('s1','s2f','Fontsize',14)

Nfft2 = 2*2^nextpow2(length(s2f)); % �chantillonnage fr�quentiel tr�s fin
% pour voir les sinc et r�cup�rer les bonnes amplitudes
f2 = -Fe2/2:Fe2/Nfft2:Fe2/2-Fe2/Nfft2;
S2f = abs(fftshift(fft(s2f,Nfft2)))/length(s2f);
figure(1), plot(f2,S2f, 'm'), hold on, grid on
xlabel('fr�quence (Hz)')
 