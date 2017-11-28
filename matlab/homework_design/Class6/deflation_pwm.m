function [eig_s,eig_v,t]=deflation_pwm(A,tol,maxit,flag)
k=length(A);
mc=cell(k,3);
mc{1,1}=A;
eig_s=zeros(k,1);
eig_v=zeros(k,k);
eig_v_temp=eig_v;
ind=1;
P=zeros((k-1)*k/2,1);
t=0;
for i=(1:k)
    [eig_v_temp(i:k,i),eig_s(i)]=sub_powmeth(mc{i,1}...
        ,rand(k-i+1,1),tol,maxit);
    mc{i,2}=f_non_zero(eig_v_temp(i:k,i),1e-4);
    eig_v_temp(i:i-2+mc{i,2},i)=0;
    mc{i,3}=mc{i,1}(mc{i,2},:);
    eig_v(:,i)=eig_v_temp(:,i);
    if i> 1
        for j=(i:-1:2)
            eig_v(j-1:k,i)=de_shift(eig_s(i),eig_s(j-1),ind_m(mc{j-1,2},...
                eig_v(j:k,i)),eig_v_temp(j-1:k,j-1),mc{j-1,3},mc{j-1,2});
            eig_v(1:k,i)=eig_v(1:k,i)/norm(eig_v(1:k,i),inf);
            P(ind)=norm((mc{j-1,1}-eig_s(i)*eye(k-j+2))...
                *eig_v(j-1:k,i),inf);
            ind=ind+1;
        end
    end
    if i==k
        break;
    else
        mc{i+1,1}=de_part(mc{i,1}-eig_v_temp(i:k,i)*mc{i,3}...
            /eig_v_temp(mc{i,2}+i-1,i),mc{i,2});
    end
end
if flag==1
    figure
    plot(P','LineStyle','-.','LineWidth',2,...
        'Color','red','Marker','o','MarkerFaceColor','yellow','MarkerSize',3)
    %     ylim([0,1e-4])
elseif flag==2
    t=max(P);
end
end
function [v]=de_shift(lambda,lambda0,u,u0,x,p)
v=(lambda-lambda0)*u+(x*u)/u0(p)*u0;
end
function B=de_part(A,p)
n=length(A);
if (p>n || p<=0)
    error('The index is not proper')
elseif p==1
    B=A(2:n,2:n);
elseif p==n
    B=A(1:n-1,1:n-1);
else
    B=[A(1:p-1,1:p-1),A(1:p-1,p+1:n);
        A(p+1:n,1:p-1),A(p+1:n,p+1:n)];
end
end
function inc=ind_m(p,v)
n=length(v);
if p==1
    inc=[0;v];
elseif p==n+1
    inc=[v;0];
else
    inc=[v(1:p-1);0;v(p:n)];
end
end
function p=f_non_zero(v,zero_ctr)
p=1;
for i=(1:length(v))
    if abs(v(i))<zero_ctr
        p=p+1;
    end
    if p>length(v)
        error('Error in Non_zero function')
    end
end
end