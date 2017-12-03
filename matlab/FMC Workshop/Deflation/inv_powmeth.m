function [x,lambda]=inv_powmeth(A,x0,tol,maxit)
%inverse power method
x=x0;
z=x/norm(x,inf);
[L,U,P]=lu(A);
x=tri_slv(L,U,P*z);
lambda=z'*A*z/(z'*z);
for k=(1:maxit)
    z=x/norm(x,inf);
    x=tri_slv(L,U,P*z);
    tmp=lambda;
    lambda=z'*A*z/(z'*z);
    if abs(lambda-tmp)<tol*lambda
        break;
    end
end
end