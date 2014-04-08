function [S_f,f] = spectrum(s_t,Ts)
%SPECTRUM Affiche la réponse fréquentielle d'un signal.
%   s_t : signal temporel
%   Ts : période d'échantillonnage

% x_t=zeros(1,length(s_t)+1);
% x_t(2:length(x_t))=s_t;

[S_f,f]=freqz(s_t,1,8192,1/Ts);

figure;
subplot(211);
plot(f,20*log10(abs(S_f)));
%plot(f,abs(S_f).^2);
title('Module de la transformée de Fourier');
xlabel('Fréquence [Hz]');
ylabel('Gain [dB]');
subplot(212);
plot(f,angle(S_f));
title('Phase de la transformée de Fourier');
xlabel('Fréquence [Hz]');
ylabel('Phase [rad]');

