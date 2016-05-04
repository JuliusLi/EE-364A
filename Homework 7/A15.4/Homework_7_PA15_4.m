% EE 364A Homework 7 Problem A15.4 %
close all; clear all;

interdict_alloc_data;

cvx_begin
    variables x(m) z(n)
    minimize (z(n))
    subject to
        x >= 0;
        x <= x_max;
        sum(x) <= B;
        A'*z >= -a.*x;
        z(1) == 0;
cvx_end
Pmax_star = exp(z(n));

x2 = (B/m)*ones(m,1);
cvx_begin
    variable z(n)
    minimize (z(n))
    subject to
        z(1) == 0;
        A'*z >= -a.*x2;
cvx_end
Pmax_unif = exp(z(n));