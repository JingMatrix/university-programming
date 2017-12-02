function [x,A]=qrdecom(A,b)
[m,n]=size(A);
%{
Q=eye(m);
% Household Direct Way
for i=(n:-1:1)
    e=zeros(m+i-n,1);
    e(1,1)=norm(A(n-i+1:m,n-i+1))*sign(-A(n-i+1,n-i+1));
    w=A(n-i+1:m,n-i+1)-e;
    c=w'*w;
    if c==0 %Whether rank(A) is 1;
        break;
    else
        P=eye(m+i-n)-(2/c)*(w*w');
        H=eye(m);
        H(n-i+1:m,n-i+1:m)=P;
        Q=H*Q;
        A=H*A;
    end
end
Q=Q';
b=Q'*b;
x=tri_qrsolve(A,b);
%}
%{
% Household technique way
S=sum(A.^2,1);
for k=(1:n)
    if S(k)<0
        break;
    end
    sig=-sign(A(k,k))*sqrt(S(k));
    w=A(k,k)-sig;
    beta=sig*(-w); % 0.5*norm(x-sigma*e(n))^2
    A(k,k)=sig;
    for j=(k+1:n)
        u=(w*A(k,j)+A(k+1:m,k)'*A(k+1:m,j))/beta;
        A(k,j)=A(k,j)-u*w;
        A(k+1:m,j)=A(k+1:m,j)-u*A(k+1:m,k);
        S(j)=S(j)-A(k,j)^2;
    end
    u=(w*b(k)+A(k+1:m,k)'*b(k+1:m))/beta;
    b(k)=b(k)-u*w;
    b(k+1:m)=b(k+1:m)-u*A(k+1:m,k);
    
end
A=triu(A);
x=tri_qrsolve(A,b);
%}
% Given Rotation
for j=1:n
    for i=j+1:m
        if A(i,j)==0
            continue;
        end
        [c_theta,s_thata]=given_Gen([A(j,j),A(i,j)]);
        Temp=[c_theta,-s_thata;s_thata,c_theta]*[A(j,j:n) b(j);A(i,j:n) b(i)];
        A(j,j:n)=Temp(1,1:n-j+1);
        b(j)=Temp(1,end);
        A(i,j:n)=Temp(2,1:n-j+1);
        b(i)=Temp(2,end);
    end
end
x=tri_qrsolve(A,b);
end
