function [x_opt, history, gap] = lp_barrier(A,b,c,x0),

mu = 20;    n = length(x0);

t = 1;  x = x0; history = [];
while(1)
    [x_opt, nu_opt, lambda] = newton_lp(A,b,c*t,x);
    x = x_opt;
    gap = n/t;
    new_entry = [length(lambda);gap];
    history = [history new_entry];
    if gap < 1e-3, break; end
    t = mu*t;
end