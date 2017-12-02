k=5;
A=rand(k,k);
z=rand(k,1);
[L,U,P]=lu(A);
x1=tri_slv(L,U,P*z);
x2=A\z;
norm(x1-x2)