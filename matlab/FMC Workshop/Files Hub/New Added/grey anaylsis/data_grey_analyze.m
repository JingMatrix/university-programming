run('data_initial.m');
dis_para=0.5;
f_seq=f_seq-min(f_seq);
f_uni=f_seq/mean(f_seq);
c_uni=c_seq./mean(c_seq);
analyze_data=abs(c_uni-f_uni);
min_data=min(min(analyze_data,2));
max_data=max(max(analyze_data,2));
gamma_data=(min_data+dis_para*max_data)./(analyze_data+dis_para*max_data);
[Coe,Ind]=sort(mean(gamma_data));
% re_t(:,2)=int16(re_t(:,2));
% V_Names={'Order','Coefficient','Index'};
output=[(1:size(c_seq,2));Ind;Coe];
% result=table((1:size(c_seq,2))',re_t(:,2),re_t(:,1),'VariableNames',V_Names);
fprintf('The No.%02d correlative sequence is X%02d, the coefficient is %f\n',...
    output);
%% plot the data
fig = figure('units','normalized','outerposition',[0 0 1 1]);
k=17;
plot_data=[ones(length(f_seq),1),gamma_data];
p=plot(years,plot_data(:,1:k)');
for i=(1:k)
p(i).LineStyle=line_S{i};
p(i).Marker=marker{i};
p(i).LineWidth=line_W{i};
% p(i).Color=color(i);
end
legend(Names_X(1:k),'Location','eastoutside');
legend('boxon');
xlabel('Years');
ylabel('Relative Coefficient');
ylim([0,1]);
grid on;
fig.Name='Result';
