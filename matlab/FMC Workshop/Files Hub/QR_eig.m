%%
a = [   2.0000    0.9157    0.7922    0.9595    0.6557    0.0357;
        0.9157    2.0000    0.6787    0.7577    0.7431    0.3922;
        0.7922    0.6787    2.0000    0.0318    0.2769    0.0462;
        0.9595    0.7577    0.0318    2.0000    0.9502    0.0344;
        0.6557    0.7431    0.2769    0.9502    2.0000    0.4898;
        0.0357    0.3922    0.0462    0.0344    0.4898    2.0000];
n = size(a,1);
obj=a;
%%
% construct a Hessenberg matrix by Household transformation
for i=1:n-2
    
    x=obj(:,i);
    for j=1:i
        x(j)=0;
    end
    y=zeros(n,1);
     
    if(x'*x==0)
        H=eye(n);
    else
        if(sign(obj(i+1,i))==0)
             c=norm(x,2);
        else
             c=sign(obj(i+1,i))*norm(x,2);
        end
        y(i+1)=1;
        w=x-norm(x,2).*y;
        
        H=eye(n)-2.*w*w'./(w'*w);
        obj=H*obj*H';
    
    end
end
obj
% reduce normal matrix into Hessenberg form
%%
R=obj;
QQQ=eye(n);
decide=0;
for i=1:1000
    Q=eye(n);
    for k=1:n-1
        c=R(k:n,k:n);
        x=c(:,1);
       
        y=norm(x,2).*eye(n+1-k,1);
        w=x-y;
        v=2.*w/(w'*w);
        temp=eye(n+1-k)-v*w';
         
        H=[eye(k-1),zeros(k-1,n+1-k);zeros(n+1-k,k-1),temp];    
        Q=H*Q;
        R=H*R;
        QQQ=H*QQQ;
    end
    
    if(i==1000)
        break;
    end
    R
    R=R*Q';   
end
% use QR iteration to get Hessenberg form's eigrnvalue 

% SUMMARY
% use QR and Hessenberg form to get eigenvalues of matrix.
% as for jacobi,en , let's see it next time