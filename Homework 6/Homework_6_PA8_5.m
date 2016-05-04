% EE 364A Homework 6 Problem A8.5 %
close all; clear all;

n = 4000; k = 100; d = 1; m = 1;

A = randn(k,n);
b = randn(k,1);

D = spdiags(ones(n,1)*[-1 2 -1], [-1 0 1],n,n);
D(1,1) = 1; D(n,n) = 1;
I = sparse(1:n,1:n,ones(n,1));
F = A'*A + d*D + m*I;
g = A'*b;

% Computing using regular matrix inverse %
tic;
xstar1 = F\g;
toc;

X = (d*D + m*I);
% Computing using efficient method %
tic;
end_term = X\g;
front_term = X\(A');
mid_term = (sparse(1:k,1:k,1) + A*front_term)\(A*end_term);
xstar2 = end_term - front_term*mid_term;

toc;

percent_error = norm(xstar2-xstar1)/norm(xstar1);