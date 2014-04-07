function [ s_t ] = expansion( F, a_k )

K = length(a_k);
s_t = zeros(K,F);
s_t(:,1) = a_k;
s_t = meshgrid(s_t',1,K*F);

end

