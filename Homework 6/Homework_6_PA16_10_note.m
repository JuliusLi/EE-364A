% EE 364A Homework 6 Problem A16.10 Notes %
close all; clear all;

lamda = 3;
alpha = 15;
eta = 5;

Pt = 4;
Tout = 70;

cvx_begin
    variable T
    minimize Pt*(alpha/eta)*(Tout^2/T + T) + lambda*(T + 40)
cvx_end
