%%% Mesures de performances d'une chaine transmission sur canal AWGN %%%

% Initialisation de l'environnement de travail
clear all;
close all;

% D�finition des pa
EbN0dB=1:8;
N=160;
NbTrames=500;

teb=zeros(1,length(EbN0dB));

%% Estimation des performances
for k=1:length(EbN0dB)
    for l=1:NbTrames
       % Transmission d'une trame
       teb_temp=simu_qpsk_awgn(EbN0dB(k),N);
       % Moyenne du TEB
       teb(k)=teb(k)+teb_temp;
    end
    teb(k)=teb(k)/NbTrames;
end

%% Performances th�oriques
peb=berawgn(EbN0dB,'pam',2);

%% Trac� des courbes de performances
figure;
semilogy(EbN0dB,teb,'-*');
hold('on');
semilogy(EbN0dB,peb,'r');
title('Courbes de performances');
xlabel('E_b/N_0 [dB]');
ylabel('Taux d''erreur');
legend('Simulation','Th�orie');