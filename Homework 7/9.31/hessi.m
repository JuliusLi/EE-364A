function hessian = hessi(x,A),
    d = 1./(1-A*x);
    hessian = A'*diag(d.^2)*A + diag(1./(1+x).^2 + 1./(1-x).^2);
end