clear;
clc;
c_list=(0.1:0.01:0.7);
m_list=(35:45);
fitdata=[];
for cond_ctr=c_list
    for rank_mat=m_list
        [A,~,~]=raw_data(rank_mat,cond_ctr);
        fitdata=[fitdata;cond_ctr,rank_mat,cond(A)];
    end
end
v_names={'CP_parameter','Rank','Condition_Number'};
relation_table=table(fitdata(:,1),fitdata(:,2),fitdata(:,3),'VariableNames'...
    ,v_names);
fit_result=fit([relation_table.CP_parameter,relation_table.Rank],...
    relation_table.Condition_Number,'poly22');
filename = 'relation_table.xlsx';
xlswrite(filename,fitdata);

