%%
a =[1.0000    0.9058    0.1270    0.9134    0.6324    0.0975    0.2785    0.5469;
    0.9058    1.0000    0.1576    0.9706    0.9572    0.4854    0.8003    0.1419;
    0.1270    0.1576    1.0000    0.9595    0.6557    0.0357    0.8491    0.9340;
    0.9134    0.9706    0.9595    1.0000    0.6555    0.1712    0.7060    0.0318;
    0.6324    0.9572    0.6557    0.6555    1.0000    0.3171    0.9502    0.0344;
    0.0975    0.4854    0.0357    0.1712    0.3171    1.0000    0.4456    0.6463;
    0.2785    0.8003    0.8491    0.7060    0.9502    0.4456    1.0000    0.4984;
    0.5469    0.1419    0.9340    0.0318    0.0344    0.6463    0.4984    1.0000];
x=[1; 2; 3; 1; 2;1;2 ;1] ;
%%
a=input('input a matrix :');

x=input('please give me a column vector :');

% above this is some crucial data input ,you can input matrixs and vectors
% in your enjoyable style.
% Tips:ensure your matrix has sufficient vectors.
%%
for k=1:500
    y=a*x;    
    v=y./norm(y,inf);
    if(norm(x-v)<1e-10||norm(x+v)<1e-10)
        disp(k);
        break
    end
    x=v;
end
disp(norm(a*x,inf));
% power meathod
%%
for k=1:500
    y=a*x;    
    v=y./norm(y,2);
    if(norm(x-v)<1e-10||norm(x+v)<1e-10)
        disp(k);
        break
    end
    x=v;
end
lam_max= v'*a*v
% power method by Raileigh Qotient
% it is stronger and more precise than above
%%
a_inv=eye(size(a))/a;
for k=1:500
    y=a_inv*x;    
    v=y./norm(y,inf);
    if(norm(x-v)<1e-10||norm(x+v)<1e-10)
        disp(k)
        break;
    end
    x=v;
end
disp(norm(a*x,inf));
% inverse power method
%%
a_inv=eye(size(a))/a;
for k=1:500
    y=a_inv*x;    
    v=y./norm(y,2);
    if(norm(x-v)<1e-10||norm(x+v)<1e-10)
        disp(k)
        break;
    end
    x=v;
end
lam_min=v'*a*v
% inverse power method by Raileigh Qotient
% it is stronger and more precise than above