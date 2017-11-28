function x=tri_slv(L,U,z)
n=length(z);
x=z;
for i=(2:n)
        x(i)=z(i)-L(i,1:i-1)*x(1:i-1);
end
if abs(U(n,n))<1e-9
    error('A is sigular!')
else
    x(n)=x(n)/U(n,n);
end
for i=(n-1:-1:1)
    if abs(U(i,i))<1e-9
        error('A is sigular!')
    else
        x(i)=(x(i)-U(i,i+1:n)*x(i+1:n))/U(i,i);
    end
end