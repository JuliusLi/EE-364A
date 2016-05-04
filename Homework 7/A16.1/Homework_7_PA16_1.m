% EE 364A Homework 7 Problem A16.1 %
close all; clear all;

rel_pwr_flow_data;

% (a) %
cvx_begin
    variables g(k) p(m)
    minimize (c'*g)
    subject to
        g >= 0;
        g <= Gmax;
        abs(p) <= Pmax;
        A*p == [-g; d];
cvx_end


% (b) %

cvx_begin
    variables g(k) p(m) Q(m,m)
    G = [-g; d];
    minimize (c'*g)
    subject to
        g >= 0;
        g <= Gmax;
        abs(p) <= Pmax;
        A*p == G;
        
        for r = 1:m,
            q = Q(:,r);
            abs(q) <= Pmax.*(1:m ~=r)';
            A*q == G;
        end
cvx_end
