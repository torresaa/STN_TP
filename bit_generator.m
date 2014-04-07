function [ b_n, m_emp, sigma2_emp ] = bit_generator( N )

b_n = rand([1,N]);
b_n = round(b_n);
m_emp = mean(b_n);
sigma2_emp = var(b_n);


end

