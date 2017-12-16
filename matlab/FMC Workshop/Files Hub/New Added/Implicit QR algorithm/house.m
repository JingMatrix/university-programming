function [x,beta] = house(x)
    %The returned x and beta present the household matrix:
    %H = I - beta*x*x'
    n = size(x);
    x = x / norm(x,inf);
    sigma = x(2:n)' * x(2:n);
    if sigma == 0
        beta = 0;
    else
        alpha = sqrt(x(1)^2 + sigma);
        sig=sign(x(1))*alpha;
        x(1)=x(1)+sig;
        beta = 2 / (sigma + x(1)^2);
    end
end
