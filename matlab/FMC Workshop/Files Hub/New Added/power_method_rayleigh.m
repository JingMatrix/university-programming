function [m,x,k]=power_method_rayleigh(A,N,eps)
%power_method_rayleigh.m   calculate the maximum eigenvalue of A
%x0 initial vector
%N the maximum number for iteration
%eps error tolerance
%written by Leila on 2017/12/09
if nargin==2
    eps=1e-6;
end
if nargin==1
    N=500;
    eps=1e-6;
end
n=size(A,1);
x=rand(n,1);
z=x/max(x);
x=A*z;
m=z'*A*z/(z'*z);
for k=1:N
    tmp=m;
    z=x/max(x);
    x=A*z;
    m=z'*x/(z'*z);
    if abs(m-tmp)<eps*abs(m)
        break;
    end
end