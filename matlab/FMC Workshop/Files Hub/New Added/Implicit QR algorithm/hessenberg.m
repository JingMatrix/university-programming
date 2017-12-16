function A = hessenberg(A)
    n = size(A,1);
    for k = 1 : n-2
        [v,beta] = house(A(k+1:n,k));
        A(k+1:n,k:n) = A(k+1:n,k:n) - beta*v*(v')*A(k+1:n,k:n);
        A(k+2:n,k) = zeros(n-k-1,1);
        A(1:n,k+1:n) = A(1:n,k+1:n) - beta*A(1:n,k+1:n)*v*(v');
    end
end