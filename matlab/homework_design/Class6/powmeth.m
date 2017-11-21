function [eig_s,eig_v]=powmeth(A,tol,maxit)
k=length(A);
eig_s=zeros(k,1);
eig_v=zeros(k,k);
for i=(k:-1:1)
    x0=rand(i,1);
    [eig_v(k-i+1:k,k-i+1),eig_s(k-i+1)]=sub_powmeth(A,x0,tol,maxit);
    e=zeros(i,1);
    e(1,1)=1;
   eig_v(k-i+1:k,k-i+1)=eig_v(k-i+1:k,k-i+1)/norm(eig_v(k-i+1:k,k-i+1),inf);
    w=eig_v(k-i+1:k,k-i+1)-e;
    c=norm(w);
    if c==0 %Whether rank(A) is 1;
        break;
    else
        w=w/c;
        P=eye(i)-2*w*w';
        T=P*A*P';
        A=T(2:i,2:i);
    end
end
end

function [x,lambda]=sub_powmeth(A,x0,tol,maxit)
x=x0;
z=x/norm(x,inf);
x=A*z;
lambda=z'*A*z/(z'*z);
for k=(1:maxit)
    z=x/norm(x,inf);
    x=A*z;
    tmp=lambda;
    lambda=z'*A*z/(z'*z);
    if abs(lambda-tmp)<tol*lambda
        break;
    end
end
end
