%-----------iterative_method----------------------------%

clear
clc
A=rand(50);
n=size(A,1);
A=A'+A+100*eye(n);

b=rand(n,1);

% A=ones(3);A(1,2)=2; A(1,3)=-2;
% A(3,1)=2; A(3,2)=2;
% n=size(A,1);
% b=rand(n,1);

% A=ones(3);
% A(1,1)=2; A(1,2)=-1; A(3,3)=-2;
% n=size(A,1);
% b=rand(n,1);

% load('A.mat');
% load('b.mat');
% n=size(A,1);

D=diag(diag(A));
AA=A;
U=D-triu(A);
xx=A\b;
%---------jacobi---------------
M=D\(D-A);
max(abs(eig(M)))
g=D\b;
x=ones(n,1);
 p=50;
e=zeros(p,1);
k=1;
e(1)=norm(x-xx);
while k<p && norm(x-xx)>1e-8
    k=k+1;
    x=M*x+g;
    e(k)=norm(x-xx);
end
plot(e,'bd-');
 hold on;
% 
% ---------------------Gauss Seidel------------
A=AA;
M=(A+U)\U;
max(abs(eig(M)))
g=(A+U)\b;
x=ones(n,1);
e=zeros(p,1);
k=1;
e(1)=norm(x-xx);
 while k<p && norm(x-xx)>1e-8
    k=k+1;
    x=M*x+g;
    e(k)=norm(x-xx);
end
plot(e,'g*-');
xlabel('迭代次数');
ylabel('误差');
hold on;
%--------------CG-------------------------
A=AA;
N=50;
x=ones(n,1);
e=zeros(N,1);
k=0; r=b-A*x;
d=r'*r;
d0=0;
while k<N && norm(x-xx)>1e-8
    k=k+1;
    if k==1
        p=r;
    else
        beta=d/d0; p=r+beta*p;
    end
    e(k)=norm(x-xx);
    w=A*p; a=d/(p'*w); x=x+a*p;
    r=r-a*w; d0=d; d=r'*r;
end
plot(e,'y*-');

