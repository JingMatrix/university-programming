% WARNING: when running this function, MATLAB will warn
% you: 'Matrix is close to singular or badly scaled.'.
% Just ignore it !

function [V,D] = myeig_for_real(A,maxit1,maxit2,tol)
%{
% This function returns the eigenvalues and eigenvectors 
% of the real matrix A with distinct eigenvalues.
% The eigenvalues are stored in the diagonal matrix D, and
% the eigenvactors are stored in each columns of V.
% To test this function, we may try: A*V - V*D.
% Addition: If A have multiple eigenvalues, 
% the accuracy of this function is not garenteed.
%}
% 'maxit1' is the iteration of inverse power method.
% 'maxit2' and 'tol' are the paremeters in 'IQR_method'.

    if nargin < 4,   tol = 1e-16;      end
    if nargin < 3,   maxit2 = 2000; end
    if nargin < 2,   maxit1 = 1;       end
    n = size(A,1);
    V = zeros(n);
    
%%
    % To transfer A into the Quasi-Schur form.
    R = IQR_method(A,maxit2,tol);

    % To calculate the eigenvalues of A(R).
    egvl = IQReigenvalue(R);

%%
    %{
    % Since we have got the eigenvalues of A, it is convinient
    % to use the inverse power (with shift) to calculate 
    % the eigenvalues. 
    % That is: we iterate with A-lambda*I, 
    % where lambda is the eigenvalue of A.
    % The iteration:
    % (A - lambda*I)*v_{k} = z_{k-1} ;
    % z_{k} = v_{k} / max(abs(v_{k})) ; 
    %}
    
    for i = 1 : n   % the i-th eigenvector
           %{
           % Here we choose initial vector z_{0} = P*L*ones(n,1),
           % so that from L*U*v_{1} = P*z_{0} = L*ones(n,1),
           % we have v_{1} = U\ones(n,1).
           % We omit the above steps and directly set 
           % v = U\ones(n,1).
           % By this method, what we really did is a
           % 'half-iteration'.
           %}
           [L,U,P] = lu( A - egvl(i)*eye(n) );
           v = U\ones(n,1);
           lambda = max(abs(v));
           z = v/max(abs(v));
           
           %## IN THIS PLACE, WE CAN ONLY ITERATE FOR ONE TIME! ##
           %     However, the result seems to be quite accurate.
           %     In fact, when rank(A) = 100, (with the default parameter)
           %     norm(A*V - V*D) is about 1e-11.
           %     For the reason, we may refer to <数值线性代数> 
           %     publiced by Peking University.

           for j = 1 : maxit1
                v = L\U\(P*z);
                z = v/max(abs(v));
           end
           V(:,i) = z;
    end
    
    % Store 'egvl' in D
        D = diag(egvl);
end