function polyeq(f1,f2,f3,f4)
B=transpose(1:4);
A=repmat(B,1,4).^repmat([3,2,1,0],4,1);
sl=A\[f1 f2 f3 f4]';
x=linspace(1,10);
y=polyval(sl,x);
plot(x,y)