function [eig_s,eig_v]=powmeth(A,tol,maxit)
k=length(A);
eig_s=zeros(k,1);
eig_v=zeros(k,k);
for i=(k:-1:1)
    x0=rand(i,1);
    [eig_v(k-i+1:k,k-i+1),eig_s(k-i+1)]=inv_powmeth(A,x0,tol,maxit);
    e=zeros(i,1);
    e(1,1)=1;
   eig_v(k-i+1:k,k-i+1)=eig_v(k-i+1:k,k-i+1)/norm(eig_v(k-i+1:k,k-i+1),2);
    w=eig_v(k-i+1:k,k-i+1)-e;
    c=norm(w);
    if c==0 %Whether rank(A) is 1;
        break;
    else
        w=w/c;
        P=eye(i)-2*(w*w');
        T=P*A*P';
        A=T(2:i,2:i);
    end
end
end
