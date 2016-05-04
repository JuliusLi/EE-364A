% EE 364A Homework 5 Problem A5.2 %
close all; clear all;

k= 201;
i = 1:k;
ti = -3 + 6*i/k;
yi = exp(ti);

x = [ones(1,k); ti; ti.^2];
ub = ti(end);     lb = ti(1);
% Bisection Algorithm loop %
astar = []; bstar = []; pstar = 0;
while ub-lb >= .001,
    p = .5*(ub+lb);
    cvx_begin quiet
        variable a(3)
        variable b(2)
        subject to
            abs(x'*a - yi'.*(x'*[1;b])) <= p*x'*[1;b];
    cvx_end
    
    if strcmp(cvx_status,'Solved'),
        ub = p;
        astar = a;
        bstar = b;
        pstar = p;
    else,
        lb = p;
    end
end

exp_approx = (x'*astar)./(x'*[1;bstar]);
exp_approx = exp_approx';

plot(ti,yi,ti,exp_approx);
