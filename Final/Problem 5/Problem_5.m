% EE 364A Final Problem 5 %
close all; clear all;

deleveraging_data;

cvx_begin quiet
    variable x0(n)
    maximize (mu'*x0 - gamma*x0'*Sigma*x0)
    subject to
        norm(x0,1) <= Linit;
cvx_end

cvx_begin quiet
    variable xT(n)
    maximize (mu'*xT - gamma*xT'*Sigma*xT)
    subject to
        norm(xT,1) <= Lnew;
cvx_end

l = sqrt(lambda);
y1 = [];
cvx_begin
    variable x(n,T-1)
    phi = sum(kappa.*abs(x(:,1)-x0)) + sum_square(l.*(x(:,1)-x0));
    J = mu'*x(:,1) - gamma*x(:,1)'*Sigma*x(:,1) - phi;
    y1 = [y1 J];
    for i = 2:T-1,
        phi = sum(kappa.*abs(x(:,i)-x(:,i-1))) + ...
            sum_square(l.*(x(:,i)-x(:,i-1)));
        y = mu'*x(:,i) - gamma*x(:,i)'*Sigma*x(:,i) - phi;
        J = J + y;
        y1 = [y1 y];
    end
    phi = sum(kappa.*abs(xT-x(:,T-1))) + sum_square(l.*(xT - x(:,T-1)));
    y = mu'*xT - gamma*xT'*Sigma*xT - phi;
    J = J + y;
    y1 = [y1 y];
    
    maximize J
    subject to
        for i = 1:T-1,
            norm(x(:,i),1) <= Linit;
        end
        
cvx_end

xt = [x0 x xT];
leverage = [];
for i = 1:T+1,
    leverage = [leverage norm(xt(:,i),1)];
end
subplot(122);
plot(0:T,leverage); hold on;


% Last period trade position %
y2 = [];
cvx_begin
    variable x(n,T-1)
    phi = sum(kappa.*abs(x(:,1)-x0)) + sum_square(l.*(x(:,1)-x0));
    J = mu'*x(:,1) - gamma*x(:,1)'*Sigma*x(:,1) - phi;
    y2 = [y2 J];
    for i = 2:T-1,
        phi = sum(kappa.*abs(x(:,i)-x(:,i-1))) + ...
            sum_square(l.*(x(:,i)-x(:,i-1)));
        y = mu'*x(:,i) - gamma*x(:,i)'*Sigma*x(:,i) - phi;
        J = J + y;
        y2 = [y2 y];
    end
    phi = sum(kappa.*abs(xT-x(:,T-1))) + sum_square(l.*(xT - x(:,T-1)));
    y = mu'*xT - gamma*xT'*Sigma*xT - phi;
    J = J + y;
    y2 = [y2 y];
    
    maximize J
    subject to
        for i = 1:T-1,
            x(:,i) == x0;
            norm(x(:,i),1) <= Linit;
        end
        
cvx_end
xt2 = [x0 x xT];
leverage = [];
for i = 1:T+1,
    leverage = [leverage norm(xt2(:,i),1)];
end
plot(0:T,leverage,'r'); hold on;


% Linearly Interpolated trades %
y3 = [];
cvx_begin
    variable x(n,T-1)
    phi = sum(kappa.*abs(x(:,1)-x0)) + sum_square(l.*(x(:,1)-x0));
    J = mu'*x(:,1) - gamma*x(:,1)'*Sigma*x(:,1) - phi;
    y3 = [y3 J];
    for i = 2:T-1,
        phi = sum(kappa.*abs(x(:,i)-x(:,i-1))) + ...
            sum_square(l.*(x(:,i)-x(:,i-1)));
        y = mu'*x(:,i) - gamma*x(:,i)'*Sigma*x(:,i) - phi;
        J = J + y;
        y3 = [y3 y];
    end
    phi = sum(kappa.*abs(xT-x(:,T-1))) + sum_square(l.*(xT - x(:,T-1)));
    y = mu'*xT - gamma*xT'*Sigma*xT - phi;
    J = J + y;
    y3 = [y3 y];
    
    maximize J
    subject to
        for i = 1:T-1,
            x(:,i) == (1-i/T)*x0 + i/T*xT;
            norm(x(:,i),1) <= Linit;
        end
        
cvx_end
xt3 = [x0 x xT];
leverage = [];
for i = 1:T+1,
    leverage = [leverage norm(xt3(:,i),1)];
end
plot(0:T,leverage,'g');
title('Holding sequence for x^\ast, x^{Lp }, and x^{Lin }');

subplot(121);
plot(1:T,y1); hold on;
plot(1:T,y2,'r');   plot(1:T,y3,'g');
title('Risk and transaction cost adjusted return');
