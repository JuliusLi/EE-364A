% EE 364A Homework 6 Problem A17.4 %
close all; clear all;

ad_disp_data;

R = R(:);

cvx_begin
    variable N(n,T)
    s = pos(q-diag(Acontr'*N*Tcontr));
    maximize (R'*N(:) - p'*s)
    subject to
        N(:) >= 0;
        ones(1,n)*N == I';
cvx_end
net_profit = cvx_optval;
revenue = R'*N(:);      payment = p'*s;

% Only using highest revenue ad in each time period %
cvx_begin
    variable N(n,T)
    maximize (R'*N(:))
    subject to
        N(:) >= 0;
        ones(1,n)*N == I';
cvx_end
revenue2 = cvx_optval;
s = pos(q-diag(Acontr'*N*Tcontr));
payment2 = p'*s;
net_profit2 = revenue2-payment2;