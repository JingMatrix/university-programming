function [A,b,x0]=raw_data(k,cond_ctr)
% Raw data generating for error test
% Input:
%   k - Matrix Rank
%   cond_ctr - condition number control agrument in aprandsym build-in
%   function; 'none' indicates using random method generation
% Output:
%   A, b and x0 stand for the matrix, the rhs vector and the initial
%   solution
if cond_ctr=='none'
    B=rand(k,k);
    A=0.5*(B'+B)+eye(k,k);
    % A=B'*B;
else
    A=sprandsym(k,0.3,cond_ctr);
    A=A+eye(k,k);
end
    b=rand(k,1);
    x0=rand(k,1);
end
