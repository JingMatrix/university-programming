function [G,x]=chky(A,b)
if any(A~=A')
    error('Matrix must be positive definite.')
end
n=length(A);
for i=1:n
    if A(i,i)<=0
         error('Matrix must be positive definite.');
    end
    A(i,i)=sqrt(A(i,i));
        A(i+1:n,i)=A(i+1:n,i)/A(i,i);
    for j=i+1:n
        A(j:n,j)=A(j:n,j)-A(j,i)*A(j:n,i);
    end
end
G=tril(A);
x=zeros(size(b));
x(1)=b(1)/G(1,1);
for i=2:n
    x(i)=(b(i)-G(i,1:i-1)*x(1:i-1))/G(i,i);
end
x(n)=x(n)/G(n,n);
for i=n-1:-1:1
    x(i)=(x(i)-G(i+1:n,i)'*x(i+1:n))/G(i,i);
end

