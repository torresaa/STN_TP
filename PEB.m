function [ TEB  ] = PEB( EbNo, N, F, D, L, alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
clc
T = 1/D;
[b_n m_emp sigma2_emp] = bit_generator(N);
a_k = mapping_2PAM(b_n) ; % + cte para Question 5
close all
s_t = expansion(F, a_k);
t_st = 0:T/F:((length(a_k)*T)-T/F);

t_filtre = [0 : T/F : L*T];
t_y = [t_st (length(a_k)*T):T/F:(length(a_k)*T)+(L/(1/F))*T/F-T/F];

%  Mise en forme SRRC 
filtre_srrc = gen_filters ('srrc', t_filtre, T, F, L, alpha);
y_srrc = conv(s_t,filtre_srrc);

x_t = y_srrc; % Par la suite, signal dans les ennonces
t_x = t_y;

sigma2_x = var(x_t);
sigma2_n = F*sigma2_x/(10^(EbNo/10));
n_t = sigma2_n*randn(1,length(x_t));
r_t = x_t + n_t;

h_r = fliplr(filtre_srrc);
p_t = conv(filtre_srrc,h_r);

t_pt = [0 : T/F : 2*L*T ];

y_t = conv(r_t,h_r);

y_t = y_t(((length(y_t)-length(s_t))/2):end-((length(y_t)-length(s_t))/2)-1);
y_k = y_t(1:16:end);

y_n = y_k > 0;
TEB = (sum(xor(y_n,b_n)))/N;
end

