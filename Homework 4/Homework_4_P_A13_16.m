% EE 364A Homework 4 Problem A13.16 %
close all; clear all;

S = .5:1.5/199:2;
V = [];
for i = 1:200,
    v1 = max(0,S(i)-1.1);   v2 = max(0,S(i)-1.2);
    v3 = max(0,.8-S(i));    v4 = max(0,.7-S(i));
    v5 = 0;
    if S(i) > 1.15,
        v5 = .15;
    elseif S(i) <= 1.15 && S(i) >= .9,
        v5 = S(i)-1;
    else,
        v5 = -.1;
    end
    v = [v1 v2 v3 v4 v5 1.05 S(i)];
    V = [V; v];
end

P = [.06; .03; .02; .01];
cvx_begin
    variable pn
    variable y(200)
    maximize pn
    subject to
        V'*y == [P; pn; 1;1];
        y >= 0;
cvx_end