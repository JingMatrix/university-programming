
clear
clc
e1=zeros(500,1);
t1=zeros(500,1);
e2=zeros(500,1);
t2=zeros(500,1);
e3=zeros(500,1);
t3=zeros(500,1);
e4=zeros(500,1);
t4=zeros(500,1);
for N=1:10:500
%生成较大的不稀疏正定矩阵

  A=randn(N);
  A=A*A';
  A=A+1*eye(N);
  
%  A=rand(N);%生成随机矩阵

  b=rand(N,1);
  AA=A;
  bb=b;
 n=N;
 xx=A\b;
 %%-----------------------------ALLGAUSS------------------------------------
 t0=cputime;
 Q=eye(n);
for k=1:n-1
    [x,y]=find(abs(A(k:n,k:n))==max(max(abs(A(k:n,k:n)))),1);
    x=x+k-1;
    y=y+k-1;
    A([k,x],:)=A([x,k],:);
    A(:,[k,y])=A(:,[y,k]);
    b([k,x])=b([x,k]);
    Q(:,[k,y])=Q(:,[y,k]);
    A(k+1:n,k)=A(k+1:n,k)/A(k,k);
    A(k+1:n,k+1:n)=A(k+1:n,k+1:n)-A(k+1:n,k)*A(k,k+1:n);
end
%对b做同样的变换
for k=1:n-1
    b(k+1:n)=b(k+1:n)-b(k)*A(k+1:n,k);
end
%前代法解上三角矩阵解
for k=n:-1:2
    b(k)=b(k)/A(k,k);
    b(1:k-1)=b(1:k-1)-b(k)*A(1:k-1,k);
end
b(1)=b(1)/A(1,1);
b=Q*b;
e1(N)=norm(xx-b);
t1(N)=cputime-t0;


%--------------------------COLUME GAUSS----------------------------------
A=AA;
b=bb;
t0=cputime;
for k=1:n-1
    [x,y]=max(max(abs(A(k:n,k:n))));
    y=y+k-1;
    A([y,k],:)=A([k,y],:);
    b([y,k])=b([k,y]);
    A(k+1:n,k)=A(k+1:n,k)/A(k,k);
    A(k+1:n,k+1:n)=A(k+1:n,k+1:n)-A(k+1:n,k)*A(k,k+1:n);
end
for k=1:n-1
    b(k+1:n)=b(k+1:n)-b(k)*A(k+1:n,k);
end
for k=n:-1:2
    b(k)=b(k)/A(k,k);
    b(1:k-1)=b(1:k-1)-b(k)*A(1:k-1,k);
end
b(1)=b(1)/A(1,1);
e2(N)=norm(xx-b);
t2(N)=cputime-t0;

%----------------------CHOLESKY FACTORIZATION-----------------------------
A=AA;
b=bb;
t0=cputime;
for j=1:n
    v=zeros(j-1,1);
    for i=1:j-1
        v(i)=A(j,i)*A(i,i);
    end
    A(j,j)=A(j,j)-A(j,1:j-1)*v(1:j-1);
    A(j+1:n,j)=(A(j+1:n,j)-A(j+1:n,1:j-1)*v(1:j-1))/A(j,j);
end
L=tril(A)-diag(diag(A))+eye(n);
for k=1:n-1
    b(k)=b(k)/L(k,k);
    b(k+1:n)=b(k+1:n)-b(k)*L(k+1:n,k);
end
b(n)=b(n)/L(n,n);
L=diag(diag(A))*L';
for k=n:-1:2
    b(k)=b(k)/L(k,k);
    b(1:k-1)=b(1:k-1)-b(k)*L(1:k-1,k);
end
b(1)=b(1)/L(1,1);
t3(N)=cputime-t0;
e3(N)=norm(xx-b);
%-----------traditional CHOLESKY------------------------------
% t0=cputime;
% for i=1:n
%     A(i,i)=sqrt(A(i,i));
%     A(i+1:n,i)=A(i+1:n,i)/A(i,i);
%     for j=i+1:n
%         A(j:n,j)=A(j:n,j)-A(j:n,i)*A(j,i);
%     end
% end
% L=tril(A);
% for k=1:n-1
%     b(k)=b(k)/L(k,k);
%     b(k+1:n)=b(k+1:n)-b(k)*L(k+1:n,k);
% end
% b(n)=b(n)/L(n,n);
% L=L';
% for k=n:-1:2
%     b(k)=b(k)/L(k,k);
%     b(1:k-1)=b(1:k-1)-b(k)*L(1:k-1,k);
% end
% b(1)=b(1)/L(1,1);
% t3(N)=cputime-t0;
% e3(N)=norm(xx-b);


%--------------------qrsolve-----------------------------
% A=AA;
% b=bb;
% t0=cputime;
% for k=1:n-1
%     [beta,v]=house(A(k:n,k));
%     A(k:n,k:n)=A(k:n,k:n)-beta*v*(v'*A(k:n,k:n));
%     b(k:n)=b(k:n)-beta*v*(v'*b(k:n));
% end
% for k=n:-1:2
%     b(k)=b(k)/A(k,k);
%     b(1:k-1)=b(1:k-1)-b(k)*A(1:k-1,k);
% end
% b(1)=b(1)/A(1,1);
% t4(N)=cputime-t0;
% e4(N)=norm(b-xx);
end

%--------------误差绘图-------------------


plot(e1,'r*');%ALL GAUSS
hold on;
plot(e2,'b*');%COLUMN GAUSS
hold on;
plot(e3,'g*');%CHOLESKY FACTORIZATION
hold on;
plot(e4,'y*');%qrsolve
xlabel('矩阵阶数');
ylabel('误差');

%------------------------时间差画图-----------

% plot(t1,'r*');%ALL GAUSS
% hold on;
% plot(t2,'b*');%COLUMN GAUSS
% hold on;
% plot(t3,'g*');%CHOLESKY FACTORIZATION
% % hold on;
% % plot(t4,'y*');%qrsolveplot(t1,'y*-');
% xlabel('矩阵阶数');
% ylabel('时间差');
























function [beta,v]=house(x)
n=length(x);
eta=max(abs(x));
x=x/eta;
d1=x(2:n)'*x(2:n);
v=zeros(n,1);
v(2:n)=x(2:n);
if d1==0
    beta=0;
else
    a=sqrt(x(1)^2+d1);
    if x(1)>0
        v(1)=x(1)-a;
    else
        v(1)=-d1/(x(1)+a);
    end
    beta=2*v(1)^2/(v(1)^2+d1); v=v/v(1);
end
end

































    

