function x = tridiag(A,f)
%  Solve the  n x n  tridiagonal sxstem for x:
%
%  [ a(1)  c(1)                                  ] [  x(1)  ]   [  f(1)  ]
%  [ b(2)  a(2)  c(2)                            ] [  x(2)  ]   [  f(2)  ]
%  [       b(3)  a(3)  c(3)                      ] [        ]   [        ]
%  [            ...   ...   ...                  ] [  ...   ] = [  ...   ]
%  [                    ...    ...    ...        ] [        ]   [        ]
%  [                        b(n-1) a(n-1) c(n-1) ] [ x(n-1) ]   [ f(n-1) ]
%  [                                 b(n)  a(n)  ] [  x(n)  ]   [  f(n)  ]
%
%  f must be a vector (row or column) of length n
%  f will be overwritten to get x
n=length(f);
a=diag(A);c=diag(A,1);b(2:n)=diag(A,-1);
c(1)=c(1)/a(1);f(1)=f(1)/a(1);c(n)=0;
% c(n)=0 is for better writting programme
for i=2:n
    a(i)=a(i)-b(i)*c(i-1);
    c(i)=c(i)/a(i);
    f(i)=(f(i)-b(i)*f(i-1))/a(i);
end
for i=n-1:-1:1
    f(i)=f(i)-c(i)*f(i+1);
end
x=f;
