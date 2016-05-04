% EE 364A Homework 5 Problem A13.9 %
close all; clear all;

p = [.5 .6 .6 .6 .2]';
q = [10 5 5 20 10]';
S = [1 1 0 0 0; 0 0 0 1 0; 1 0 0 1 1; 0 1 0 0 1; 0 0 1 0 0];

cvx_begin
    variable x(5) %integer
    variable t
    maximize t
    subject to
        x >= 0;
        x <= q;
        for j = 1:5,
            x'*(p- S(:,j)) >= t;
        end
cvx_end

% caculating worst case house profit for x = q %
wchp = 1e10; % Initializing house profit to a high value
for j = 1:5,
    profit_j = q'*(p-S(:,j));
    wchp = min(wchp, profit_j);
end

% Calculating imputed probabilities %
cvx_begin
    variable ppi(5)
    maximize (x'*(p-S*ppi));
    subject to
        eye(5)*ppi >=0;
        ones(1,5)*ppi == 1;
cvx_end