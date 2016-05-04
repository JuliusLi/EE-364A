function gradient = grad(x,A),
    gradient = A'*(1./(1-A*x)) - 1./(1+x) + 1./(1-x);
end