% EE 364A Homework 7 Problem A9.31 (b) %
close all; clear all;

% (b) %
n = 100;    m = 200;
randn('state',1);
A = randn(m,n);
alpha = .05; beta = .5;
% Step sizes and threshhold %
iter = 1000;        % Maximum iterations to avoid infinite loop in testing.
eta = (.001)^2;

x = zeros(n,1); Values = []; T = [];
for i = 1:iter,
    F = f(x,A);
    Values = [Values F];
    G = grad(x,A);
    H = hessi_diag(x,A);
    dx = -H\G;
    lambda_squared = abs(G'*dx);
    t = 1;
    while (max(A*(x+t*dx)) >=1 | max(abs(x+t*dx)) >=1),
        t = beta*t;     % This step ensures f(x) is real
    end
    while (f(x+t*dx,A) >= F + alpha*t*G'*dx),
        t = beta*t;     % This is the backtracking step
    end
    T = [T t];
    x = x+t*dx;
    if(lambda_squared <= eta), break; end;
end

result = f(x,A);    Values = [Values result];

subplot(121); plot(1:length(Values),Values-result);
title('Diagonal Approx. Convergence'); xlabel('iteration');
ylabel('f - p^\ast');
subplot(122); plot(1:length(T), T,'x');
title('Diag Approx Newton step size');
xlabel('iteration'); ylabel('t');