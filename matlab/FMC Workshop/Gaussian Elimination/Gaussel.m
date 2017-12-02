function [A,b,x]=Gaussel(A,b,tol)
[m,n] = size(A);
% Compute the default tolerance if none was provided.
if (nargin < 3), tol = max(m,n)*eps(class(A))*norm(A,'inf'); end
% Loop over the entire matrix.
i = 1;
j = 1;
while (i <= m) && (j <= n)
    % Find value and index of largest element in the remainder of column j.
    [p,k] = max(abs(A(i:m,j))); k = k+i-1;
    % k referd the index.
    if (p <= tol)
        % The column is negligible,end the function;
        break;
    else
        % Swap i-th and k-th rows.
        A([i k],j:n) = A([k i],j:n);
        b([i k])=b([k i]);
        % Divide the pivot row by the pivot element.
        b(i)=b(i)/A(i,j);
        A(i,j:n) = A(i,j:n)/A(i,j);
        % Subtract multiples of the pivot row from all the other rows.
        for k = i+1:m
            b(k)=b(k)-A(k,j)*b(i);
            A(k,j:n) = A(k,j:n) - A(k,j)*A(i,j:n);
        end
        i = i + 1;
        j = j + 1;
    end
end
x=b;
% calculate x.
for i=n-1:-1:1
    x(i)=x(i)-A(i,i+1:n)*x(i+1:n);
end

