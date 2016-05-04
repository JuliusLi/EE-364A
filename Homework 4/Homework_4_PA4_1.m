% EE 364A Homework 4 Problem A4.1 %
close all; clear all;

u1 = -2;    u2 = -3;

B = [1 -.5; -.5 2];
c = [1; 0];
A = [1 2; 1 -4; 5 76];
b = [u1; u2; 1];


cvx_begin
    variable x(2)
    dual variable lambda
    minimize(quad_form(x,B) - c'*x)
    subject to
        lambda: A*x <= b;
cvx_end

% part (b) %
pexact = [];
Del_vals = [];
delta = .1;
for d1 = -delta:delta:delta,
    for d2 = -delta:delta:delta,
        D = [d1; d2];
        Del_vals = [Del_vals D];
        
        b_new = b + [d1; d2; 0];
        
        cvx_begin
            variable x(2)
            minimize(quad_form(x,B) -c'*x)
            subject to
                A*x <= b_new;
        cvx_end
        pstar = cvx_optval;
        pexact = [pexact pstar];
    end
end