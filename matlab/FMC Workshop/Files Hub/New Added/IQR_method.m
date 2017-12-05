%{
% This is the implicit QR method for a real matrix
%(the eigenvalue algorithm), which returns the
% Quasi-Schur matrix R that is similar and congruent to A (, R has the same
% eigenvalues of A, which are what we're mainly caring about). 
% M is the upper bound of iterations.
% ~ ~ ~ ~
% The main algorithm is the Francis' double-shifts QR algorithm.
%(The codes for a single step of doubleQR are given in line 71)
%}
function [R,iteration] = IQR_method(A,M)
% Hint: We should first deal with the line 20,117 and 129. 
    if nargin < 2
        M = 2000;
    end
    
    n = size(A,1);
    
    % To transfer A into a hessenberg matrix
    H = hessenberg(A);% We should add the function in our folders 
    % or just replace this line with the codes at the bottom.
    
    for iteration = 1:M
        
        % To turn H(i,i-1) that is small enough to 0, so that it's easier
        % for us to determine whether to stop the iteration.
        for i = 2 : n
            if (abs(H(i,i-1)) <= (abs(H(i,i)) + abs(H(i-1,i-1)))*1e-16)
                H(i,i-1) = 0;
            end
        end
        
    %{
        % Since the doubleQR method works only when H is not reducible
        % (that is H has no zero in its lower quasi-diagnal line),
        % we are going to decompose H into a block-diagonal metrix, whose diagonal
        % are H1,H2 and H3, where H3 is in quasi-schur form and H2 is irreducible.
        % In the following codes, we are computing
        %  m = size(H3,1)  and  l = size(H2,1) + size(H3,1) . 
        % Also, we hope that m and l is as large as possible.
        %}        
        d = diag(H,-1);

        % to count m :
        m = 0;
        while (m < n-2) 
            if (d(n-1-m) ~= 0) && (d(n-2-m) ~= 0)
                break;
            end
            m = m + 1;
        end

        % in this field,m = n - 2 means that H is already in quasi-schur
        % form, so we just stop.
        if m == n - 2
            break;
        end

        % to count l :
        l = m + 1;
        while (l < n - 1)
            if d(n-1-l) == 0
                break;
            end
            l = l + 1;
        end
        l = l + 1;


    %{
    % Apply hessenberg transformation to H2 (computing together with other
    % components of H).
    % The standard doubleQR codes are like:
    % 
            function H = doubleQR(H)
                n = size(H,1);
                m = n - 1;
                s = H(m,m) + H(n,n);
                t = H(m,m)*H(n,n) - H(m,n)*H(n,m);
                x = H(1,1)*H(1,1) + H(1,2)*H(2,1) - s*H(1,1) + t;
                y = H(2,1) * (H(1,1) + H(2,2) -s);
                z = H(2,1) * H(3,2);
                for k = 0 : n-3
                    %Since in the first and last several steps,the algorithm is a
                    %little different ,the two integers 'q' and 'r' are used for
                    %brevity.
                    [v,beta] = house([x,y,z]');
                    q = max(1,k);
                    H(k+1:k+3,q:n) = H(k+1:k+3,q:n) - beta*v*(v')*H(k+1:k+3,q:n);
                    r = min(k+4,n);
                    H(1:r,k+1:k+3) = H(1:r,k+1:k+3) - beta*H(1:r,k+1:k+3)*v*(v');
                    x = H(k+2,k+1);
                    y = H(k+3,k+1);
                    if k < n-3
                        z = H(k+4,k+1);
                    end
                end
                [v,beta] = house([x,y]');
                H(m:n,n-2:n) = H(m:n,n-2:n) - beta*v*v'*H(m:n,n-2:n);
                H(1:n,m:n) = H(1:n,m:n) - beta*H(1:n,m:n)*v*(v');
            end
        
    % The following code maybe a little confusing since it contains too
    % many indices. However, if you compare it to the function 'doubleQR'
    % above, you will discover that the only difference between them are
    % the corresponding indices which are not very important. 
    %}

        s = H(n-m-1,n-m-1) + H(n-m,n-m);
        t = H(n-m-1,n-m-1)*H(n-m,n-m) - H(n-m-1,n-m)*H(n-m,n-m-1);
        x = H(n-l+1,n-l+1)*H(n-l+1,n-l+1) + H(n-l+1,n-l+2)*H(n-l+2,n-l+1) - s*H(n-l+1,n-l+1) + t;
        y = H(n-l+2,n-l+1) * (H(n-l+1,n-l+1) + H(n-l+2,n-l+2) -s);
        z = H(n-l+2,n-l+1) * H(n-l+3,n-l+2);
        for h = 0 : l-m-3
            % Since in the first and last steps,the algorithm is a little 
            % different, two integers 'q' and 'r' are used for brevity.
            [v,beta] = house([x,y,z]');% We should add the function in our folders 
            % or just replace this line with the codes at the bottom.
            q = max(1,h);
            H(n-l+h+1:n-l+h+3,n-l+q:n) = H(n-l+h+1:n-l+h+3,n-l+q:n) - beta*v*(v')*H(n-l+h+1:n-l+h+3,n-l+q:n);
            r = min(n-l+h+4,n-m);
            H(1:r,n-l+h+1:n-l+h+3) = H(1:r,n-l+h+1:n-l+h+3) - beta*H(1:r,n-l+h+1:n-l+h+3)*v*(v');
            x = H(n-l+h+2,n-l+h+1);
            y = H(n-l+h+3,n-l+h+1);
            if n-l+h < n-m-3
                z = H(n-l+h+4,n-l+h+1);
            end
        end
        [v,beta] = house([x,y]');
        H(n-m-1:n-m,n-m-2:n) = H(n-m-1:n-m,n-m-2:n) - beta*v*(v')*H(n-m-1:n-m,n-m-2:n);
        H(1:n-m,n-m-1:n-m) = H(1:n-m,n-m-1:n-m) - beta*H(1:n-m,n-m-1:n-m)*v*(v');
    end
    R = H;
end

%{
% My function for a hessenberg transformation:
    function A = hessenberg(A)
        n = size(A,1);
        for k = 1 : n-2
            [v,beta] = house(A(k+1:n,k));
            A(k+1:n,k:n) = A(k+1:n,k:n) - beta*v*(v')*A(k+1:n,k:n);
            A(1:n,k+1:n) = A(1:n,k+1:n) - beta*A(1:n,k+1:n)*v*(v');
        end
    end


% My function of householder trans. :

    function [x,beta] = house(x)
        %The returned x and beta present the household matrix:
        %H = I - beta*x*x'
        n = size(x);
        x = x / max(abs(x));
        sigma = x(2:n)' * x(2:n);
        if sigma == 0
            beta = 0;
        else
            alpha = sqrt(x(1)^2 + sigma);
            if x(1) <= 0
                x(1) = x(1) - alpha;
            else
                x(1) = -sigma / (x(1) + alpha);
            end
            beta = 2*x(1)^2 / (sigma + x(1)^2);
        end
        x = x/x(1);
    end
%}