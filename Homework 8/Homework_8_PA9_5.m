% EE 364A Homework 8 Problem A9.5 %
close all; clear all;

m = 10;
n = 200;

% (a) %
rand('seed',0); randn('seed',0);
A = [randn(m,n);ones(1,n)]; 
x0 = rand(n,1) + 0.5;
b = A*x0;
c = randn(n,1);

figure;
[x_opt, nu_opt, lambda] = newton_lp(A,b,c,x0); 
semilogy(lambda); xlabel('Newton Steps');
ylabel('\lambda^2/2');  title('(a)');

figure;
[x_opt, history, gap] = lp_barrier(A,b,c,x0);
[xx, yy] = stairs(cumsum(history(1,:)),history(2,:)); 
semilogy(xx,yy);  xlabel('Newton Steps');   ylabel('gap');
title('(b)');