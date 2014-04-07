%%  Projet Systemes de Transmision Numerique

% Definitions
% ---------------------
%   D: debit binaire
%   T: duree symbole
% ---------------------

%   N : nombre de bits aleatoires
%   b_n : sequence de bits aleatoires genere
%   u_emp: moyenne empirique de b_n
%   sigma2_emp: variance empiriaue de b_n
%   a_k : Symboles 
%   F: Facteur de surechantillonage
%   s_t: vecteur surechantillonne

% -------------------------------------------
% Liste des Fonctions
%  Generator de bits aleatoires:
%   [b_n, m_emp, sigma2_emp] = bit_generator (N)    
%  Mapping 2-PAM
%   [a_k] = mapping_2PAM (b_n)
%  Expansion 
%   [s_t] = expansion (F, a_k)


%%
