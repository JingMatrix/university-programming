function H=francis_qr(A,maxit,ceps)
  % Let H be an upper Hessenberg matrix. This algorithm computes its real Schur form using the Francis double step QR algorithm.
  H=hess(A);
  n=length(H);
  p=n;
  % p indicates the ‘active’ matrix size.
  while p>2
    q=p-1;
    s=H(q,q)+H(p,p);
    % compute first 3 elements of first column of M
    t=H(q,q)*H(p,p)-H(p,q)*H(q,p);
    x=H(1,1)^2+H(1,2)*H(2,1)-s*H(1,1)+t;
    y=H(2,1)*(H(1,1)+H(2,2)-s);
    z=H(2,1)*H(3,2);
    for k=(0:p-3)
      [x,beta]=gallery('house',[x;y;z]);
      r=max([1,k]);
      H(k+1:k+3,r:n)=H(k+1:k+3,r:n)-(beta*x)*x'*H(k+1:k+3,r:n);
      r=min([k+4,p]);
      H(1:r,k+1:k+3)=H(1:r,k+1:k+3)-H(1:r,k+1:k+3)*(beta*x)*x';
      x=H(k+2,k+1);
      y=H(k+3,k+1);
      if k<p-3
        z=H(k+4,k+1);
      end
    end
    [x,beta]=gallery('house',[x;y]);
    H(q:p,p-2:n)=H(q:p,p-2:n)-(beta*x)*x'*H(q:p,p-2:n);
    H(1:p,p-1:p)=H(1:p,p-1:p)-H(1:p,p-1:p)*(beta*x)*x';
    % check for convergence
    if abs(H(p,q))<ceps*(abs(H(q,q))+abs(H(p,p)))
      H(p,q)=0;
      p=p-1;
      q=p-1;
    elseif abs(H(p-1,q-1))<ceps*(abs(H(q-1,q-1))+abs(H(p,p)))
      H(p-1,q-1)=0;
      p=p-2;
      q=p-1;
    end
  end
