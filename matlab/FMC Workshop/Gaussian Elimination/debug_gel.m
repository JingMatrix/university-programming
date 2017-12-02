tic;
A1=[-4 1 0 0 0 1;
    3 -7 2 0 2 0;
    0 4 -7 3 0 0;
    0 0 1 -5 4 0;
    0 2 0 6 -11 3;
    3 0 0 0 3 -8];
b1=[-200;0;0;0;0;0];
[A,b,x]=Gaussel_mex(A1,b1,1e-6);
toc;
x0=A1\b1;
toc;
T=table(x,x0,'VariableNames',{'Gaussel','built_in'})
%{
output=cat(2,(1:length(b1))',[x,x0])';
fprintf('V%d in Guassel:%5.3f     Matlab_built-in: %5.3f\n',output);
%}