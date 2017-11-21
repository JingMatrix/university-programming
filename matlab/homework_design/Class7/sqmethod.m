function x=sqmethod(A,b)
A1=A'*A;
b=A'*b;
[~,x]=chky(A1,b);
end
