function [eig_s,eig_v,t]=deflation_pwm(A,tol,maxit,flag)
% This function implements the deflation power method in
% find eigen system for matrix A.
% Input:
% A - the matrix to find eigen system
% tol - the tolerable error in difference comparing in the
%   power method
% maxit - the max iteration in each power method step
%   flag - whether generate the eigenvector errors figure
% 1 for yes, 0 for no, 2 for simple information
% Output:
% eig_s - the eigenvalues of A
% eig_v - the eigenvectors of A
% t - parameter the indicate the error in eig_v
k=length(A);
% A的大小
mc=cell(k,3);
% mc is a data structure 
% mc:第一列用于存放每一次降阶的矩阵；第二列用于
% 存放对应矩阵的特征向量非零元素的位置p；第三列
% 用于存放需要记载下来的该矩阵第p行元素；
mc{1,1}=A;
% 初始化计算矩阵A
eig_s=zeros(k,1);
eig_v=zeros(k,k);
eig_v_temp=eig_v;
% 初始化用于存放数据的变量
ind=1;
P=zeros((k-1)*k/2,1);
% ind与P用于误差统计，其长度是由所有回代的总步
%数决定的为1到k-1求和
t=0;
% 特征向量误差的初值
for i=(1:k)
    [eig_v_temp(i:k,i),eig_s(i)]=sub_powmeth(mc{i,1}...
        ,rand(k-i+1,1),tol,maxit);
    mc{i,2}=f_non_zero(eig_v_temp(i:k,i),1e-4);
    eig_v_temp(i:i-2+mc{i,2},i)=0;
    mc{i,3}=mc{i,1}(mc{i,2},:);
	% 计算第i个数据节点
    eig_v(:,i)=eig_v_temp(:,i);
	% 开始进入特征向量的回代过程
    if i> 1
        for j=(i:-1:2)
            eig_v(j-1:k,i)=de_shift(eig_s(i),eig_s(j-1),ind_m(mc{j-1,2},...
                eig_v(j:k,i)),eig_v_temp(j-1:k,j-1),mc{j-1,3},mc{j-1,2});
            eig_v(1:k,i)=eig_v(1:k,i)/norm(eig_v(1:k,i),inf);
			% 回代一次
            P(ind)=norm((mc{j-1,1}-eig_s(i)*eye(k-j+2))...
                *eig_v(j-1:k,i),inf);
            ind=ind+1;
			% 计算这一次回代后的特征向量的准确性
        end
    end
    if i==k
        break;
		%判断是否跳出，不保存冗余数据
    else
        mc{i+1,1}=de_part(mc{i,1}-eig_v_temp(i:k,i)*mc{i,3}...
            /eig_v_temp(mc{i,2}+i-1,i),mc{i,2});
    end
end
if flag==1
    %根据参数，决定画图
    figure
    plot(P','LineStyle','-.','LineWidth',2,...
        'Color','red','Marker','o','MarkerFaceColor','yellow','MarkerSize',3)
    %     ylim([0,1e-4])
elseif flag==2
    t=max(P);
	% flag为2不画图时，输出误差图中的最大值
end
end
function [v]=de_shift(lambda,lambda0,u,u0,x,p)
%用于回代到上一个矩阵的特征向量
v=(lambda-lambda0)*u+(x*u)/u0(p)*u0;
end
function B=de_part(A,p)
%用于处理特征向量的零元素问题
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
%用于控制零元素的判断方法
for i=(1:length(v))
    if abs(v(i))<zero_ctr
        p=p+1;
    end
    if p>length(v)
        error('Error in Non_zero function')
    end
end
end
