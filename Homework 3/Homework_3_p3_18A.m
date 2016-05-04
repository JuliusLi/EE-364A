% EE 364A Homework 3 Problem A3.18 %
close all; clear all;

rand('state',0);
n=100; m=300;
A = rand(m,n);
b = A*ones(n,1)/2;
c = -rand(n,1);

cvx_begin
    variable xr(n)
    minimize(c'*xr);
    subject to
        A*xr <= b
        xr >= 0;
        xr <= 1;
cvx_end
L = cvx_optval;

t = 1/n:1/n:1;  %Carrying out rounding for 100 values of t
obj = []; maxviol = [];
for i = 1:n,
    x_hat = (xr >= t(i));
    obj = [obj c'*x_hat];
    maxviol = [maxviol max(A*x_hat-b)];
end

feasible = (maxviol <= 0);
U = min(obj(feasible));

% Generating plots %
subplot(211);
plot(t,maxviol,t, zeros(1,n),'--'); 
title('maximum violation vs. threshhold');
xlabel('threshhold'); ylabel('maximum violation');

subplot(212);
plot(t,obj,t,U*ones(1,n),'--'); 
title('objective value vs threshhold');
xlabel('threshhold'); ylabel('c^Tx');