% EE 364A Homework 7 Problem A9.31 %
close all; clear all;

% (a) %
n = 100;    m = 200;
randn('state',1);
A = randn(m,n);
alpha = .05; beta = .5; eta = .01;
% Step sizes and threshhold %
iter = 1000;        % Maximum iterations to avoid infinite loop in testing.

eta = (.001)^2;
Nvals = [1 15 30];
Iters = [];

for N = Nvals;
    Values = []; T = [];
    x = zeros(n,1);
    for i = 1:iter,
        H = hessi(x,A);
        L = chol(H,'lower');
        lambda_squared = 100;
        for j = 1:N,
            F = f(x,A);
            Values = [Values F];
            G = grad(x,A);
            dx = -L'\(L\G);
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
        if(lambda_squared <= eta | i == iter), 
            Iters = [Iters i];
            break; 
        end;
    end

    result = f(x,A);    % Result found is -144.6979
    Values = [Values result];
    
    % Plotting convergence and step sizes %
    P = 2*find(Nvals == N)-1;
    subplot(3,2,P);  
    plot(1:length(Values),Values-result); 
    title(['Convergence N = ' num2str(N)]);
    ylabel('f - p^\ast');  xlabel('iteration');
    P = 2*find(Nvals == N);
    subplot(3,2,P);  
    plot(1:length(T),T, 'x'); 
    ylabel('t'); xlabel('iteration'); 
    title(['Step size N = ' num2str(N)]);
end
pause;

% Finding approximate number of flops for each N size %
approx_flops = [];
for i = 1:3,
    N = Nvals(i);
    iterations = Iters(i);
    factorizations = ceil(iterations/N);
    factor_cost = n^3/3;
    solve_cost = 2*n^2;
    flops = iterations*solve_cost + factorizations*factor_cost;
    
    approx_flops = [approx_flops flops];
end
close all;
plot(Nvals,approx_flops); title('Approximate flop count');
xlabel('N'); ylabel('Relative flop count');