% EE 364A Homework 6 Problem A17.3 %
close all; clear all;

fba_data;

% (a) %
cvx_begin
    variable v(n)
    dual variable lambda
    maximize v(end)
    subject to
        S*v == 0;
        lambda: v <= vmax;
        v >= 0;
cvx_end
Gstar = cvx_optval;

% (b) %
Gmin = .2*Gstar;
Essential_Genes = [];
for i = 1:n-1,      
    % Clearly i = n, i.e. "cell growth gene", is essential for  %
    % cell growth since setting vmax(n) == 0 will necessitate   %
    % Gstar_new = 0. Therefore, I will leave it out of          %
    % "Essential_Genes"under the assumption it is essential.    %
    new_vmax = vmax.*(1:n ~= i)' + 1e-3*ones(n,1);
    % The addition of the last term keeps cvx from generating a %
    % Inaccurate/Solved Status since otherwise it produces a    %
    % value v_i that is very small but negative so the v >= 0   %
    % constraint would not be met.                              %
    cvx_begin quiet
        variable v(n)
        maximize v(end)
        subject to
            S*v == 0;
            v <= new_vmax;
            v >= 0;
    cvx_end
    
    if(cvx_optval <= Gmin),
        Essential_Genes = [Essential_Genes i];
    end
end