% EE 364A Homework 5 Problem A6.10 %
close all; clear all;

r = -30:70;
n = length(r);
mu1 = 8; mu2 = 20; sigma1 = 6; sigma2 = 17.5;
rho = -.25;
% Setting up denominator %
d1 = 0;     d2 = 0;
for j = 1:n,
    d1 = d1 + exp(-(r(j)-mu1)^2/(2*sigma1^2));
    d2 = d2 + exp(-(r(j)-mu2)^2/(2*sigma2^2));
end
% Setting up marginal distributions %
p1 = [];    p2 = [];
for i = 1:n,
    prob1 = exp(-(r(i)-mu1)^2/(2*sigma1^2))/d1;
    prob2 = exp(-(r(i)-mu2)^2/(2*sigma2^2))/d2;
    
    p1 = [p1; prob1];
    p2 = [p2; prob2];
end
X = r'*ones(1,n);
Y = ones(n,1)*r;
Z = zeros(n,n);
Z(X+Y <= 0) = 1;

XY = X.*Y;
cvx_begin
    variable P(n,n) nonnegative
    variable t
    maximize t
    subject to
        sum(P.*Z) >= t;     % Maximize objective
        P*ones(n,1) == p2;      % R2 marginal
        ones(1,n)*P == p1';     % R1 marginal
        XY(:)'*P(:) == rho*sigma1*sigma2 + mu1*mu2;  
        % Correlation condition.
cvx_end

Ploss = sum(sum(P.*Z))/sum(sum(P));

subplot(211); mesh(P); title('Mesh plot of pdf');
subplot(212); contour(P); title('Contour plot of pdf');