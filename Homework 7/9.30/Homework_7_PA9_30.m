% EE 364A Homework 7 Problem A9.30 %
close all; clear all;

% (a) %
n = 100;    m = 200;
randn('state',1);
A = randn(m,n);
alpha = .05; beta = .5; eta = .01;
% Step sizes and threshhold %
iter = 1000;        % Maximum iterations to avoid infinite loop in testing.

x = zeros(n,1);     % initial value for gradiant method
Values = [];    T = [];
for i = 1:iter,
    F = f(x,A);
    Values = [Values F];
    G = grad(x,A);
    dx = -G;
    
    t = 1;
    while (max(A*(x+t*dx)) >=1 | max(abs(x+t*dx)) >=1),
        t = beta*t;     % This step ensures f(x) is real
    end
    while (f(x+t*dx,A) >= F + alpha*t*G'*dx),
        t = beta*t;     % This is the backtracking step
    end
    T = [T t];
    x = x+t*dx;
    if(norm(G,2) <= eta), break; end;
end

result = f(x,A);    % Minimum result found is -144.6979
Values = [Values result];
subplot(221);   plot(1:length(Values),Values-result); 
title('Gradient Convergence');
ylabel('f - p^\ast');  xlabel('iteration');
subplot(222);   plot(1:length(T),T,'x'); 
ylabel('t'); xlabel('iteration'); title('Gradient step size');


% (b) %
eta = (.001)^2;
Values = []; T = [];
x = zeros(n,1);
for i = 1:iter,
    F = f(x,A);
    Values = [Values F];
    G = grad(x,A);
    H = hessi(x,A);
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

result = f(x,A);    % Result found is -144.6979
Values = [Values result];


subplot(223);   plot(1:length(Values),Values-result); 
title('Newton Convergence');
ylabel('f - p^\ast');  xlabel('iteration');
subplot(224);   plot(1:length(T),T, 'x'); 
ylabel('t'); xlabel('iteration'); title('Newton Step size');

