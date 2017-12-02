clc;
clear;
k=10;
tol=1e-9;
maxit=1e4;
D=rand(k,k);
% D(1,1:4)=0;
B=sort(rand(k,1),'descend');
A=D*diag(B)*inv(D);
[eig_s,eig_v,t]=deflation_pwm(A,tol,maxit,1);
[eig_s,B]