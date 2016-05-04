% Homework 2 Problem 3.2A %
close all; clear all;

cvx_begin
    variable a(2)
    minimize(a(1)+a(2))
    
    2*a(1)+a(2) >= 1;
    a(1)+3*a(2) >=1;
    a >= 0;
cvx_end

cvx_begin
    variable b(2)
    minimize(-b(1)-b(2))
    
    2*b(1)+b(2) >= 1;
    b(1)+3*b(2) >=1;
    b >= 0;
cvx_end

cvx_begin
    variable c(2)
    minimize(c(1))
    
    2*c(1)+c(2) >= 1;
    c(1)+3*c(2) >=1;
    c >= 0;
cvx_end

cvx_begin
    variable d(2)
    minimize(max(d))
    
    2*d(1)+d(2) >= 1;
    d(1)+3*d(2) >=1;
    d >= 0;
cvx_end

cvx_begin
    variable e(2)
    minimize(e(1)^2 + 9*e(2)^2)
    
    2*e(1)+e(2) >= 1;
    e(1)+3*e(2) >=1;
    e >= 0;
cvx_end
