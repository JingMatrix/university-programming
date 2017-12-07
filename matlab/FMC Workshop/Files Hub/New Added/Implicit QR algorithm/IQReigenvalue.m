function egvl = IQReigenvalue(R)
% This function returns the eigenvalues of a Quasi-Schur form R.
    n = size(R,1);
    k = 1;
    egvl = zeros(n,1);
    
    % Since R is a up-triangle-block matrix, it's easy to get the
    % eigenvalues.
    while k < n
        if R(k+1,k) ~= 0  %When the diagonal element is 2x2.
            s = R(k,k) + R(k+1,k+1);
            t = R(k,k)*R(k+1,k+1) - R(k,k+1)*R(k+1,k);
            egvl(k) = (s + sqrt(s^2 - 4*t)) / 2;
            egvl(k + 1) = s - egvl(k);
            k = k + 1;
        else % When the diagonal element is 1x1.
            egvl(k) = R(k,k);
        end
        k = k + 1;
    end
    if egvl(n) == 0
        egvl(n) = R(n,n);
    end
end