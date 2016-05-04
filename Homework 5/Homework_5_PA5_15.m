% EE 364A Homework 5 Problem A5.15 %
close all; clear all;

quad_metric_data;
s = .5*n*(n+1);     % dimension of P

Z = X - Y;  A = [];
for i = 1:N,
    z = Z(:,i);
    row = [];
    for j = 1:n,
        for k = 1:j,
            entry = z(j)*z(k);
            if i~=j, entry = 2*entry;    end
            row = [row entry];
        end
    end
    A = [A; row];
end
B = A.^.5;
cvx_begin
    variable p(s)
    variable q
    minimize q
    subject to
        for i = 1:N,
            norm(d'- B*p) <= q;
        end
        [p(1) p(2) p(4) p(7) p(11); p(2) p(3) p(5) p(8) p(12); ...
            p(4) p(5) p(6) p(9) p(13); p(7) p(8) p(9) p(10) p(14);...
            p(11) p(12) p(13) p(14) p(15)] == semidefinite(n);
cvx_end


P = [p(1) p(2) p(4) p(7) p(11); p(2) p(3) p(5) p(8) p(12); ...
            p(4) p(5) p(6) p(9) p(13); p(7) p(8) p(9) p(10) p(14);...
            p(11) p(12) p(13) p(14) p(15)];
        
Ztest = X_test-Y_test;
MSE = 0;
for i = 1:N_test,
    z = Ztest(:,i);
    dist = (d_test(i) - (z'*P*z)^.5);
    MSE = MSE + dist;
end
MSE = MSE/N_test;
