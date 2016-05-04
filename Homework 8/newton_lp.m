function [x_opt, nu_opt, lambda] = newton_lp(A,b,c,x0) 

alpha = .01;    beta = 0.5;
Iters = 100;

if (min(x0) <= 0) || (norm(A*x0 - b) > 1e-3),
    nu_opt = []; x_opt = []; lambda=[];
    return;
end

m = length(b);  n = length(x0);
x = x0;         lambda = []; 
for iter = 1:Iters,
    H = diag(x.^(-2));
    g = c - x.^(-1);

    v = (A*diag(x.^2)*A')\(-A*diag(x.^2)*g); 
    step = -diag(x.^2)*(A'*v + g);
    lam2 = -g'*step;
    lambda = [lambda lam2/2];
    if lam2/2 <= 1e-3,  break; end

    t = 1; 
    while min(x+t*step) <= 0, t = beta*t; end


    while c'*(t*step)-sum(log(x+t*step))...
            +sum(log(x))-alpha*t*g'*step> 0,
        t = beta*t;
    end
    x = x + t*step;
end

if iter == Iters,
    x_opt = []; nu_opt = [];
else
    x_opt = x;
    nu_opt = v;
end