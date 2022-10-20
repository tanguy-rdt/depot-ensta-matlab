clear all; close all;

% Ouverture du fichier de données GPS
fichier = 'data_gps_long.txt';
fid = fopen(fichier,'r');
A = fscanf(fid,'%f %f %f %f %f %f %f %f %f \r',[9,54675]);
fclose(fid);
hauteur_brute = A(9,:); clear A
fe = 1; % frequence d'échantillonnage
t = (0:1:length(hauteur_brute)-1)*1/fe;
figure, plot(t, hauteur_brute,'r'); xlabel('t (s)');ylabel('hauteur (m)');

% question 2
hauteur_brute_centre = hauteur_brute - mean(hauteur_brute);
figure, plot(t, hauteur_brute_centre,'b'); xlabel('t (s)');ylabel('hauteur (m)');
figure, plot(t, hauteur_brute,'r'); hold on; 
        plot(t, hauteur_brute_centre,'b');
        legend('hauteur brut', 'hauteur brute centre');
        xlabel('t (s)');ylabel('hauteur (m)');

% question 3
s_altitude_1h = hauteur_brute(46000:max(t));
duree_1h = 3600;
N = round(fe * duree_1h);
t_1h = (0:N-1)./fe;

Nfft = N;
fft_s_altitude_1h = fft(s_altitude_1h, Nfft);  % Spectre d'amplitude entre [0,fe]
fft_s_altitude_1h = fftshift(fft_s_altitude_1h); % Spectre en [fe/2 fe/2]
freq = -fe/2:fe/Nfft:((fe/2)-(fe/Nfft)); % fenêtre centré en [fe/2 fe/2]


densite_spectral = ((fft_s_altitude_1h).^2)/N;
densite_spectral_db = 10*log10(densite_spectral);

figure, 
plot(freq, densite_spectral_db);
title("Fréquencielle du sinal altitude");
xlabel('Fréquences'); ylabel('dB')


% Quetion 4
s_altitude = hauteur_brute_centre;
N = round(fe * max(t));

Nfft = length(s_altitude);
fft_s_altitude = fft(s_altitude, Nfft);  % Spectre d'amplitude entre [0,fe]
fft_s_altitude = fftshift(fft_s_altitude); % Spectre en [fe/2 fe/2]
freq = -fe/2:fe/Nfft:((fe/2)-(fe/Nfft)); % fenêtre centré en [fe/2 fe/2]

densite_spectral = ((fft_s_altitude).^2)/N;
densite_spectral_db = 10*log10(densite_spectral);

figure, 
plot(freq, densite_spectral_db);
title("Fréquencielle du sinal altitude");
xlabel('Fréquences'); ylabel('dB')

%% partie 2
% Question 2
Nfft = length(s_altitude);
f0 = 2.2371e-5;
freq = -fe/2:fe/Nfft:((fe/2)-(fe/Nfft)); % fenêtre centré en [fe/2 fe/2]
teta = 2*pi*1i*(freq/fe);
teta0 = 2*pi*1i*(f0/fe);
R = 0.95;
z = exp(teta);

Hf = (z.^(2)-2*cos(teta0)*z+1)./(z.^(2)-2*R*cos(teta0)*z+R.^2);

sF = Hf .* s_altitude;

fft_sF= fft(sF, Nfft);  % Spectre d'amplitude entre [0,fe]
fft_sF = fftshift(fft_sF); % Spectre en [fe/2 fe/2]
freq = -fe/2:fe/Nfft:((fe/2)-(fe/Nfft)); % fenêtre centré en [fe/2 fe/2]

% question 3
densite_spectral = ((fft_sF).^2)/N;
densite_spectral_db = 10*log10(densite_spectral);

figure, plot(freq, densite_spectral_db); hold on; 
        plot(freq, Hf);
        legend('Signal filtré', 'module du filtre');
        xlabel('t (s)');ylabel('hauteur (m)');


% question 4
figure, 
plot(freq, densite_spectral_db);
title("Signal filtré");
xlabel('Fréquences'); ylabel('dB')

figure, 
plot(freq, Hf);
title("module du filtre");
xlabel('Fréquences'); ylabel('Amplitude')

% question 5
figure, 
plot(freq, densite_spectral_db);
title("Signal filtré");
xlabel('Fréquences'); ylabel('dB')



