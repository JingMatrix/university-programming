clear;
clc;
cond_ctr='none';
mit=1e4;
tol=1e-7;
c_list=(0.1:0.2:0.8);
count=1;
for cond_ctr=c_list
for j=1:400
    k=40;
    [A,b,x0]=raw_data(k,cond_ctr);
    C(:,:,2)=diag(diag(A));
    C(:,:,1)=eye(k,k);
    for i=1:2
        [~,itr_pcg(j,i)]=cgp(x0,A,b,C(:,:,i),mit,tol);
    end
    itr_pcg;
end
%subplot(length(c_list),1,count)
figure
count=count+1;
p(1).LineStyle=':';
p(2).LineStyle='-.';
p(1).LineWidth = 2;
p(2).LineWidth = 1.5;
p(1).Marker = 's';
p(2).Marker = 'o';
ylim([6 inf])
legend('CG','Jacobi PCG','Location','best')
title('iterations for ''CG'' and ''PCG''')
ylabel('iterations')
xlabel('Fixed matrix rank 40')
end
