function [c,s]=given_Gen(vec)
mat=[vec(1) -vec(2);vec(2) vec(1)]\[1;0];
t=norm(mat);
c=mat(1)/t;
s=mat(2)/t;
end