function [x, k] = cgp(x0,A,b,C,mit,tol)
% Synopsis:
% x0: initial point
% A: Matrix A of the system Ax=b
% C: Preconditioning Matrix can be left or right
% mit: Maximum number of iterations
% tol: residue norm tolerance
% x: Estimated solution point
% k: Number of iterations done
%
r=b-A*x0;
tir=C\r;
p=tir;
x=x0;
for k=(1:mit)
    d=A*p;
    alpha=(tir'*r)/(d'*p);
    x=x+alpha*p;
    temp_r=r;
    temp_tir=tir;
    if norm(r)<tol
        break;
    end
    r=r-alpha*d;
    tir=C\r;
    beta=(r'*tir)/(temp_r'*temp_tir);
    p=tir+beta*p;
end
end


