function A=HilbertMatrix(n)
X = 1:n;
A= 1./(bsxfun(@plus,X',X)-1);