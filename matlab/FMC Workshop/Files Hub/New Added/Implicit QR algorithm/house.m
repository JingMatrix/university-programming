function [x,beta] = house(x)
    %The returned x and beta present the household matrix:
    %H = I - beta*x*x'
    n = size(x);
    x = x / max(abs(x));
    sigma = x(2:n)' * x(2:n);
    if sigma == 0
        beta = 0;
    else
        alpha = sqrt(x(1)^2 + sigma);
        if x(1) <= 0
            x(1) = x(1) - alpha;
        else
            x(1) = -sigma / (x(1) + alpha);
        end
        beta = 2*x(1)^2 / (sigma + x(1)^2);
    end
    x = x/x(1);
end
    