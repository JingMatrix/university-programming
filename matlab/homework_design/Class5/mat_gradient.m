function [x,itr] = mat_gradient(A,b,method,iteration,x0,tol)
% mat_gradient  Conjugate Gradient Method or Steepest Descent Method
% Input:
%   A - input matrix
%   b - vector b
%   x0 - initial vector
%   method - sd,cg or sm;
%   Steepest Descent Method, Conjugate Gradient Method or small w setting
%   tol - tolerance  The default is 1e-10.
%   itaration - setting the max iteration; 'auto' for default setting
if nargin==4
    x0=zeros(b);
    tol=1e-10;
elseif nargin==5
    tol=1e-10;
elseif nargin~=6
    error('mat_gradient: invalid input parameters');
end
r = b - A*x0;
e=[];
if norm(r) < tol
    itr=0;
    return
end
x=x0;
if method=='cg'
    if iteration=='auto'
        iteration=length(b);
    end
    p=r;
    w=r'*r;
    for itr=1:iteration
        y=A*p;
        temp=w;
        alpha=w/(p'*y);
        x=x+alpha*p;
        r=r-alpha*y;
        w=r'*r;
        if sqrt(w)<tol
            break
        end
        beta=w/temp;
        p=r+beta*p;
    end
elseif method=='sm'
    if iteration=='auto'
        iteration=1e5;
    end
    for itr=1:iteration
        p=r;
        y=A*p;
        w=r'*r;
        e=[e,w];
        if sqrt(w)<tol
            break
        end
        alpha=0.001;
        x=x+alpha*p;
        r=r-alpha*y;
    end
else
    if iteration=='auto'
        iteration=1e5;
    end
    for itr=1:iteration
        y=A*r;
        w=r'*r;
        if sqrt(w)<tol
            break;
        end
        alpha=(r'*r)/(r'*y);
        x=x+alpha*r;
        r=r-alpha*y;
    end
end


