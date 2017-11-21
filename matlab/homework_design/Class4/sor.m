function [ x, err, iter, flag ] = sor(A, x, b, method, w, max_it, tol)
%
% [ x, err, iter, flag ] = sor(A, x, b, method, w, max_it, tol)
%
% SOR Successive Over-Relaxation Method or Jocbi Successive Method
%   This function solves linear equation systems such as Ax=b using SOR
%   method (Successive Over-Relaxation).
%   When the relaxation scalar w=1, the method used is Gauss-Seidel.
%
% Input:
%   A - input matrix
%   x - initial vector
%   b - vector b
%   method - sor or jacobi
%   w - relaxation scalar
%   max_it - maximum number of iterations
%   tol - tolerance
%
% Output:
%   x - solution vector
%   err - norm err estimate
%   iter - number of performed iterations
%   flag - 0 = a solution was found / 1 = no convergence for max_it
%
if nargin == 4
    w = 1.0;
    max_it = 1e4;
    tol = 1e-7;
elseif nargin == 5
    max_it = 1e4;
    tol = 1e-7;
elseif nargin == 6
    tol = 1e-7;
elseif nargin ~= 7
    error('sor: invalid input parameters');
end

flag = 0;
iter = 0;

r = b - A*x;
err = norm(r);
if (err < tol)
    return
end
if method=='sor'
    b=w*b;
    t=2;
else
    t=1;
end
% separate A into several matrix for Gauss-Seidel
[ M, N] = matsep(A, b, w, t);
for iter = 1 : max_it
    x_1 = x;
    disp(x);
    x = M \ (N * x + b); % adjust the aproximation
    %err = norm(x - x_1)
    err = norm(x_1 - x, Inf); % compute error
    if (err <= tol) % check for convergence
        break
    end
end
if (err > tol) % no convergence
    flag = 1;
end

end

