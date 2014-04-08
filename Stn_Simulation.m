%%  Projet Systemes de Transmision Numerique

% Definitions
% ---------------------
%   D: debit binaire
%   T: duree symbole
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

[b_n m_emp sigma2_emp] = bit_generator(N);
a_k = mapping_2PAM(b_n);
s_t = expansion(F, a_k);
t_st = 0:1/(F*D):((length(a_k)/D)-1/(F*D));
figure 
plot(t_st,s_t);grid on;xlabel('t (secondes)');ylabel('s(t)'); 
% T = 1us, T_total = 2,048 ms
title('Expansion de signal a_k');