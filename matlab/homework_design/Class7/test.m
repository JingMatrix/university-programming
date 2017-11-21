clc;
clear;
m=6;n=4;
A=rand(m,n);
A(:,n)=A(:,1)+A(:,2);
b=rand(m,1);
[x1,R]=qrdecom(A,b);
[U,S,V] = svd(A);
S(1:3,1:3)=inv(S(1:3,1:3));
V*S'*U'*b-x1
