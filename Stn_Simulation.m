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

% -------------------------------------------
% Liste des Fonctions
%  Generator de bits aleatoires:
%   [b_n, m_emp, sigma2_emp] = bit_generator (N)    
%  Mapping 2-PAM
%   [a_k] = mapping_2PAM (b_n)
%  Expansion 
%   [s_t] = expansion (F, a_k)


%%
N = 2048; 
F = 16;
D = 10^6;
L = 8;
T = 1/D;    % Pour mod 2-PAM

[b_n m_emp sigma2_emp] = bit_generator(N);
a_k = mapping_2PAM(b_n);
s_t = expansion(F, a_k);
t_st = 0:T/F:((length(a_k)*T)-T/F);

figure 
plot(t_st,s_t);grid on;xlabel('t (secondes)');ylabel('s(t)'); 
% T = 1us, T_total = 2,048 ms
title('Expansion de signal a_k');

%OJO: Esto No Sirve, error con los tiempos de concatenado y de duracion de
%filtro
t_filtre = [0 : T/F : L*T];
t_y = [t_st (length(a_k)*T):T/F:((length(a_k)/D)+T/F*(F-2))];

%  Mise en forme NRZ 
filtre_nrz = gen_filters ('nrz', t_filtre, T, F, L, 0);
y_nrz = conv(s_t,filtre_nrz);
figure
plot(t_y, y_nrz);

[S_nrz f_nrz] = spectrum(y_nrz, T); 



