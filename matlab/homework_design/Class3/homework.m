%% problem 1
A1=[5.0 1.2 0.3 -0.6;
    1.2 6.0 -0.4 0.9;
    0.3 -0.4 8.0 1.7;
    -0.6 0.9 1.7 10.0];
b1=[2.0 4.0 2.0 1.0]';
[G,x1]=chky(A1,b1);
%% problem 2
n=8;
A2=diag(repmat(2,[1,n]))+diag(repmat(-1,[1,n-1]),1)...
    +diag(repmat(-1,[1,n-1]),-1);
b2=(2*pi/(n+1))^2*(sin(2*pi/(n+1)*(1:n)))';
x2=tridiag(A2,b2);
%% output l
disp(x1');disp(x2');