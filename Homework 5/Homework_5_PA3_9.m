% EE 364A Homework 5 Problem A3.9 %
close all; clear all;
% (c) %
m = 30; n = 100;

% complex least L2 norm %
A = randn(m,n) + i*randn(m,n);  % setup
b = randn(m,1) + i*randn(m,1);

% solution %
Ar = real(A); Ai = imag(A);
br = real(b); bi = imag(b);

bc = [br; bi];
Ac = [Ar -Ai; Ai Ar];

cvx_begin
    variable z(2*n)
    minimize (z'*z)           % Square of 2-norm
    subject to
        Ac*z == bc;
cvx_end
x_2 = z(1:n) + i*z(n+1:2*n);

% complex least inf norm %
% Note: SOCP method had too many second-order cone constraints to 
% easily enter them all.
cvx_begin
    variable x(n) complex
    minimize (norm(x,inf))
    subject to
        A*x == b;
cvx_end
x_inf = x;      % This line is only to have clearly named variables

axis equal;    
scatter(real(x_2),imag(x_2),'xk');  hold on;
scatter(real(x_inf),imag(x_inf),'or');
grid on;
