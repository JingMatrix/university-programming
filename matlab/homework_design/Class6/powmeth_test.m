clc;
clear;
k=5;
tol=1e-9;
maxit=1e4;
test_t=50;
error_s=zeros(test_t,1);
error_v=zeros(test_t,1);
flag=0;
for j=(1:test_t)
    D=rand(k,k);
    D(1,1:4)=0;
    B=sort(rand(k,1),'descend');
    A=D*diag(B)*inv(D);
    [eig_s,eig_v,error_v(j)]=deflation_pwm(A,tol,maxit,2);
    error_s(j)=norm(B-eig_s,inf);
    if (error_v(j)>0.1 || error_s(j)>0.1)
        flag=1;
        break;
    end
end
if flag==1
    figure;
    p=plot([error_s,error_v]);
    % ylim([0,1e-1])
    p(1).LineStyle='-.';
    p(2).LineStyle='-';
    p(1).LineWidth = 2;    p(2).LineWidth = 1.5;
    p(1).Marker = 's';
    p(2).Marker = 'o';
    legend('Value Error','Vector Error','Location','best')
end
% [eig_s,B]