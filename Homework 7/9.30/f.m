function value = f(x,A),
    m = size(A,1); n = size(A,2);
    value = -sum(log(ones(m,1)-A*x)) - sum(log(1+x)) - sum(log(1-x));
end