function [ a_k ] = mapping_2PAM( b_n )

a_k = 2*b_n-1;
% graficar la constelacion plot()
plot(real(a_k),imag(a_k),'lineStyle','none','marker','x','lineWidth',3);
title('Constellation de a_k'); grid on;
xlim([-2 2 ]);
end

