% EE 364A Homework 6 Problem A5.10 %
close all; clear all;

sparse_lds_data;

T = 100;    n = 8;  m = 4;
xt = xs(:,1:T-1);
xtp1 = xs(:,2:T);
Wmh = inv(Whalf);   % Wmh = W^(-1/2) %

cvx_begin
    variables Ahat(n,n) Bhat(n,m)
        y = 0;
        for i = 1:T-1,
            s = norm(Wmh*(xtp1(:,i) - Ahat*xt(:,i) - Bhat*us(:,i)),2);
            s = pow_pos(s,2);
            y = y+s;
        end
        sparsity_vector = reshape([Ahat Bhat],(m+n)*n,1);
    minimize  norm(sparsity_vector,1)
    subject to
        y <= n*(T-1) + 2*sqrt(2*n*(T-1));
cvx_end

% Sparsifying by removing values close to 0 %
Ahat = Ahat.*(abs(Ahat) >= .01);
Bhat = Bhat.*(abs(Bhat) >= .01);

% Calculating false negatives %
FNA = (A ~= 0) & (Ahat == 0);
FNB = (B ~= 0) & (Bhat == 0);
false_negatives = sum(sum([FNA FNB]));

% Calculating false positives %
FPA = (A == 0) & (Ahat ~= 0);
FPB = (B == 0) & (Bhat ~= 0);
false_positives = sum(sum([FPA FPB]));
