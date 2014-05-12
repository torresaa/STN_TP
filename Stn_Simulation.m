%%  Projet Systemes de Transmision Numerique

% Definitions
% ---------------------
%   D: debit binaire
%   T: duree symbole
%   L: facteur temps symbole
% ---------------------

%   N : nombre de bits aleatoires
%   b_n : sequence de bits aleatoires genere
%   m_emp: moyenne empirique de b_n
%   sigma2_emp: variance empiriaue de b_n
%   a_k : Symboles 
%   F: Facteur de surechantillonage
%   s_t: vecteur surechantillonne
%   t_st: temps de la signal s_t
%   alpha: coefficient de roll-off pour srrc
%   Faltan toas las ys de los filtros********************************
%   x_t: signal filtré (srrc)
%   t_x: temps du signal x_t
%   EbNo: Rapport signal à bruit du signal en dB
%   sigma2_x: variance du signal x_t
%   sigma2_n: variance du bruit
%   n_t: vecteur de bruit
%   r_t: signal x_t bruité
%   h_r: filtre adaptée
%   p_t: convolution entre filtre de mise en forme et filtre adaptée
%   y_t: sortie du filtre de reception
%   y_k: Symboles reçues
%   y_n: sequence de bits reçu
%   TEB: Taux d'erreur binaire

% -------------------------------------------
% Liste des Fonctions
%  Generator de bits aleatoires:
%   [b_n, m_emp, sigma2_emp] = bit_generator (N)    
%  Mapping 2-PAM
%   [a_k] = mapping_2PAM (b_n)
%  Expansion 
%   [s_t] = expansion (F, a_k)


%%  Definitions et Question 1
clc; clear all; close all;
N = 2048; 
F = 16;
D = 1*10^6;
L = 8;
T = 1/D;    % Pour mod 2-PAM
alpha = 0.5;
EbNo = 20; % en dB

[b_n m_emp sigma2_emp] = bit_generator(N);
a_k = mapping_2PAM(b_n); % + cte para Question 5
s_t = expansion(F, a_k);
t_st = 0:T/F:((length(a_k)*T)-T/F);

figure 
plot(t_st,s_t);grid on;xlabel('t (secondes)');ylabel('s(t)'); 
% T = 1us, T_total = 2048 ms
title('Expansion de signal a_k');

t_filtre = [0 : T/F : L*T];
t_y = [t_st (length(a_k)*T):T/F:(length(a_k)*T)+(L/(1/F))*T/F-T/F];

%%  Question 2
%   Mise en forme NRZ 
filtre_nrz = gen_filters ('nrz', t_filtre, T, F, L, 0);
y_nrz = conv(s_t,filtre_nrz);
figure
plot(t_filtre, filtre_nrz);grid on;xlabel('t(secondes)');ylabel('amplitude'); 
%xlim([0 0.00005]);
title('Réponse Impulsionnelle h_t - Filtre NRZ')
[S_nrz f_nrz] = spectrum(filtre_nrz, T/F); 

%  Mise en forme RZ 
filtre_rz = gen_filters ('rz', t_filtre, T, F, L, 0);
%y_rz = conv(s_t,filtre_rz);
figure
plot(t_filtre, filtre_rz);grid on;xlabel('t(secondes)');ylabel('amplitude'); 
%xlim([0 0.00005]);
title('Réponse Impulsionnelle h_t - Filtre RZ')
[S_rz f_rz] = spectrum(filtre_rz, T/F);  


%  Mise en forme SRRC 
filtre_srrc = gen_filters ('srrc', t_filtre, T, F, L, alpha);
y_srrc = conv(s_t,filtre_srrc);
figure
plot(t_filtre, filtre_srrc);grid on;xlabel('t(secondes)');ylabel('amplitude'); 
%xlim([0 0.00005]);
title('Réponse Impulsionnelle h_t - Filtre SRRC')
[S_srrc f_srrc] = spectrum(filtre_srrc, T/F); 

%%  Question 3
x_t = y_srrc; % Par la suite, signal dans les ennonces
t_x = t_y;

figure
subplot(2,1,1)
plot(t_x,x_t);grid on; title('Signal x_t');xlabel('t (secondes)');ylabel('Volts');
xlim([0.002 0.00207]);
subplot(2,1,2)
plot(t_st,s_t);grid on; title('Signal s_t');xlabel('t (secondes)');ylabel('Volts');
xlim([0.002 0.00207]);
% OJO: Mostrar que las senales no son del mismo grande, pero en x_t los
% ultimos valores son ceros

%%  Question 4
%fft(corr2(s_t,s_t)); Se comenta en el informe pero no se hace por fea
%fft(corr2(x_t,x_t));

figure
psd(spectrum.welch,s_t,'Fs',D); % LLega hasta 500kHz porque es hasta Fs/2
figure
psd(spectrum.welch,x_t,'Fs',D);

%%  Question 5
% Sumar cte para cambiar la media, meter graficas y explicar

%%  Question 6
% Responder pregunta teorica 
sigma2_x = var(x_t);
sigma2_n = F*sigma2_x/(2*(10^(EbNo/10)));
n_t = sqrt(sigma2_n)*randn(1,length(x_t));
r_t = x_t + n_t;

%% Question 7: Responder pregunta teorica

%% Question 8 
% ojo nombrar las variables y definir vector de tiempo de ahi verificar que
% el maximo de p_t este en Ts (pregunta 9) 
h_r = fliplr(filtre_srrc);
p_t = conv(filtre_srrc,h_r);
figure
subplot(3,1,2);
plot(t_filtre,h_r);grid on;title('Filtre adaptée');
subplot(3,1,3);
t_pt = [0 : T/F : 2*L*T ];
plot(t_pt,p_t);grid on;title('Filtre p_t');
subplot(3,1,1);
plot(t_filtre,filtre_srrc);grid on;title('Filtre de mise en forme');

%% Question 9
% nombrar variables
y_t = conv(r_t,h_r);
eyepattern(y_t,T,F,3,1,1)

%% Question 10-11-12
y_t = y_t(((length(y_t)-length(s_t))/2):end-((length(y_t)-length(s_t))/2)-1);
y_k = y_t(1:16:end);

%% Question 13
figure
plot(real(y_k),imag(y_k),'lineStyle','none','marker','x','lineWidth',3);
title('Constellation de y_k'); grid on;
xlim([-2 2 ]);
y_n = y_k > 0;
TEB = (sum(xor(y_n,b_n)))/N;


%% Question 14
% vect_TEB = [];
% for EbNo = 0:0.5:20
%    TEB =  PEB (EbNo,10^6,F,D,L,alpha);
%    vect_TEB = [vect_TEB TEB];
% end
% EbNo = 0:0.5:20;
% figure
% loglog(EbNo,vect_TEB);
% hold on
% loglog(EbNo,erfc(sqrt(2*EbNo)),'r');
% grid on;
% legend('Courbe empirique','Courbe theorique')
% xlabel('EbNo');ylabel('Pe');title('BER')