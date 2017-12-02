function x=tri_qrsolve(A,b)
[m,n]=size(A);
x=zeros(n,1);
tag=0;
for j=(n:-1:1)
    if norm(A(j,:))<1e-9
        tag=1;
        continue;
    else
        break;
    end
end
if tag==0
    x(n)=b(n)/A(n,n);
    for k=(n-1:-1:1)
        x(k)=(b(k)-A(k,k+1:n)*x(k+1:n))/A(k,k);
    end
else
    temp=(A(1:j,:)*A(1:j,:)')\b(1:j);
    x=A(1:j,:)'*temp;
end
%x=A\b;
%x=A(1:n,:)\b(1:n);
end