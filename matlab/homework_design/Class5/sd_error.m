clc;clear;
in_k=(1:1:10);
% in_k array indicate Way_A test, whose entry is used as test matrix rank.
k_s=min(in_k);
% for making data table.
tol=1e-9;
% c.f. comment in function file conjgrad.m
rank0=8;n0=100;
% rank0 and n0 indicate Way_B test, which stand the fixed matrix rank and 
% test times.
cond_ctr=0.01;
% c.f. comment in fuction file raw_data.m
for k=in_k
    [A,b,x0]=raw_data(k,cond_ctr);
    [x,itr] = mat_gradient(A,b,'sd',1e2,x0,tol);
    accurate_x=A\b;
    cond_temp=cond(A);
    err=norm(accurate_x-x);
    t1(k-k_s+1,:)=[k,itr,err,cond_temp];
end
% generating error data for Way_A
vnames={'Rank','Iteration','Error','Condition_Number'};
op_table1=table(t1(:,1),t1(:,2),t1(:,3),t1(:,4),'VariableNames',vnames);
% generating data table for Way_A
figure
subplot(3,1,1);
plot(t1(:,1),t1(:,3),'Color','blue','LineStyle','-','LineWidth',1.2,...
    'Marker','d','MarkerFaceColor','yellow','MarkerSize',3);
title({'Caculation error in matlab V.s. rank of matix',...
    'in Steepest Descent Method'});
xlabel('Rank of matrix');
ylabel('Error');
axis([k_s k_s+length(in_k)-1 0 inf]);
subplot(3,1,2);
plot(t1(:,4),t1(:,3),'LineStyle','none','LineWidth',1.2,...
    'Marker','o','MarkerFaceColor','yellow','MarkerSize',9);
title({'Caculation error in matlab V.s. condition number of matix',...
    'in Steepest Descent Method'});
xlabel('Condition Number of matrix');
ylabel('Error');
% two plots are about visulizing data in Way_A
subplot(3,1,3);
for k=1:n0
    [A,b,x0]=raw_data(k,cond_ctr);
    [x,itr] = mat_gradient(A,b,'sd',1e2,x0,tol);
    accurate_x=A\b;
    cond_temp=cond(A);
    err=norm(accurate_x-x);
    if err>1e2
        si_count=si_count+1;
        coll{si_count}={A,b,x0,cond_temp};
    end
    t2(k-k_s+1,:)=[k,itr,err,cond_temp];
end
% generating error data for Way_B
op_table2=table(t2(:,1),t2(:,2),t2(:,3),t2(:,4),'VariableNames',vnames);
% generating data table for Way_B
plot(t2(:,4),t2(:,3),'LineStyle','none','LineWidth',1.2,...
    'Marker','o','MarkerFaceColor','yellow','MarkerSize',9);
str=sprintf(join(['Caculation error in matlab V.s. cond_n of matix',...
    '\n for fixed rank of matrix','\n in Steepest Descent Method']));
title(str);
xlabel(['Condition Number of matrix(fixed rank ',num2str(rank0),')']);
ylabel('Error');
% plot about visulizing data in Way_B
%{
si_count
coll=coll(1:si_count);
disp(sortrows(op_table1,'Condition_Number'));
disp(sortrows(op_table1,'Error'));
disp(sortrows(op_table2,'Condition_Number'));
disp(sortrows(op_table2,'Error'));
figure
subplot(3,1,1)
plot(t2(:,4),t2(:,3),'LineStyle','none','LineWidth',1.2,...
    'Marker','o','MarkerFaceColor','yellow','MarkerSize',9);
title(str);
xlabel(['Condition Number of matrix(fixed rank ',num2str(rank0),')']);
ylabel('Error');
ylim([0 1e2]); 
subplot(3,1,2)
plot(t2(:,4),t2(:,3),'LineStyle','none','LineWidth',1.2,...
    'Marker','o','MarkerFaceColor','yellow','MarkerSize',9);
title(str);
xlabel(['Condition Number of matrix(fixed rank ',num2str(rank0),')']);
ylabel('Error');
ylim([0 1e3]); 
subplot(3,1,3)
plot(t2(:,4),t2(:,3),'LineStyle','none','LineWidth',1.2,...
    'Marker','o','MarkerFaceColor','yellow','MarkerSize',9);
title(str);
xlabel(['Condition Number of matrix(fixed rank ',num2str(rank0),')']);
ylabel('Error');
ylim([0 1e7]); 
%}
