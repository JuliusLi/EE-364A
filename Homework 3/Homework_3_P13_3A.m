% EE 364A Homework 3 Problem A13.3 %
close all; clear all;

simple_portfolio_data;
unif_return = pbar'*x_unif;

% (a) %
% No additional Constraints (1) %
cvx_begin
    variable p1(n)
    minimize(p1'*S*p1)
    subject to
        ones(1,n)*p1 == 1;
        pbar'*p1 == pbar'*x_unif;
cvx_end
p_star1 = cvx_optval;

% Long-only (2) %
cvx_begin
    variable p2(n)
    minimize(p2'*S*p2)
    subject to
        ones(1,n)*p2 == 1;
        pbar'*p2 == pbar'*x_unif;
        p2 >= 0;
cvx_end
p_star2 = cvx_optval;

% Limit on total short position (3) %
cvx_begin
    variable p3(n)
    minimize(p3'*S*p3)
    subject to
        ones(1,n)*p3 == 1;
        pbar'*p3 == pbar'*x_unif;
        ones(1,n)*(max(-p3,zeros(n,1))) <= .5;
cvx_end
p_star3 = cvx_optval;

% (b) %
% Long-only %
Risk = [];
Return = [];
for logmu = -10:.1:25,
    mu = exp(logmu);
    cvx_begin
    variable x(n)
    minimize(-pbar'*x + mu*x'*S*x)
    subject to
        ones(1,n)*x == 1;
        x >= 0;
    cvx_end
    Risk = [Risk x'*S*x];       % Risk vector contains variances
    Return = [Return pbar'*x];
end
subplot(211); plot(Risk.^.5, Return); 
title('Long-only Risk-Return tradeoff');
xlabel('Standard Deviation of Return');
ylabel('Expected Value of Return');

% Total Short-position limited %
Risk = [];
Return = [];
for logmu = -10:.1:25,
    mu = exp(logmu);
    cvx_begin
    variable x(n)
    minimize(-pbar'*x + mu*x'*S*x)
    subject to
        ones(1,n)*x == 1;
        x >= 0;
        ones(1,n)*(max(-x,zeros(n,1))) <= .5;
    cvx_end
    Risk = [Risk x'*S*x];       % Risk vector contains variances
    Return = [Return pbar'*x];
end
subplot(212); plot(Risk.^.5, Return); 
title('Short-Limited Risk-Return tradeoff');
xlabel('Standard Deviation of Return');
ylabel('Expected Value of Return');