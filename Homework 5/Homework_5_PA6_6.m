% EE 364A Homework 5 Problem A6.6 %
close all; clear all;

ml_estim_incr_signal_data;


y = yhat + randn(103,1);
cvx_begin
    variable xml(N)
    variable t
    minimize t
    subject to
        norm(y' - conv(xml,h)) <= t;
        xml >= 0;      % nonnegativity
        for s = 1:N-1,
            xml(s) <= xml(s+1);   % nondecreasing monotically
        end
cvx_end
subplot(211)
plot(1:100,xml,'r',1:100,xtrue,'k'); 
title('Constrained ML estimator');


% Free ML estimation %
cvx_begin
    variable xmlf(N)
    variable t
    minimize t
    subject to
        norm(y'-conv(xmlf,h)) <= t;
cvx_end
subplot(212);
plot(1:100,xmlf,'r',1:100,xtrue,'k'); 
title('Unconstraied ML estimator');