function [eig_s,eig_v]=powmeth(A,tol,maxit)
% power method 
% It is easy to understand
% 该函数可以决定是否调用反幂法
% 该函数可以正确输出特征值，但是对特征向量未作
% 处理，输出的值只是中间量，价值不大
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
