% EE 364A Homework 6 Problem A11.4 %
close all; clear all;

blend_design_data;

cvx_begin
    variable theta(k)
    logwidths = log(W)*theta;
    subject to
        log(P)*theta <= log(P_spec);
        log(D)*theta <= log(D_spec);
        log(A)*theta <= log(A_spec);
        theta >= 0;
        ones(1,k)*theta == 1;
        logwidths <= log(W_max);
        logwidths >= log(W_min);
cvx_end

widths = exp(log(W)*theta);