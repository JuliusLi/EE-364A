% EE 364A Homework 4 Problem A5.13 %
close all; clear all;

cens_fit_data;
XM = X(:,1:M);

% Including censored data %
cvx_begin
    variable c_hat(20)
    minimize norm(y - XM'*c_hat, 2)
    subject to
        c_hat'*X(:,M+1:K) >= D;
cvx_end

% Excluding censored data %

cvx_begin
    variable cls(20)
    minimize norm(y-XM'*cls,2)
cvx_end

% Calculation of relative errors %
IRel_err = norm(c_true-c_hat,2)/norm(c_true,2);
% Including censored data, Relative error = 0.1538 %

ERel_err = norm(c_true-cls,2)/norm(c_true,2);
% Excluding censored data, Relative error = 0.3907 %