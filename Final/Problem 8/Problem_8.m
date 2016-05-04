% EE 364A Final Problem 8 %
close all; clear all;

lyap_exp_bound_data;


% (c) % 
cvx_begin
    variable Ph(n,n)
    variable x(n)
    variables gam bet
    minimize gam
    subject to
        for i = 1:K,
            norm(Ph*A{i},2) <= gam;
        end
        Ph == semidefinite(n);
cvx_end

P = Ph'*Ph;
gam = gam/norm(Ph,2);


% (d) %
numSteps = 1000;
x0 = randn(n);
k = [];
for iter = 1:5,
    x = x0; traj = [];
    Kiter = [];
    for step = 1:numSteps,
        Am = []; val = -Inf;
        for i = 1:7,
            v = x'*A{i}'*P*A{i}*x;
            if v >= val,
                Am = A{i};
                val = v;
            end
        end
        x = Am*x;
        kval = norm(x)^(1/step);
        traj = [traj x];
        Kiter = [Kiter kval];
    end
    xtraj{iter} = traj;
    k = [k; Kiter];
    subplot(5,1,iter);
    plot(1:numSteps,Kiter); hold on;
    plot(1:numSteps,gam,'r-');
end
