% EE 364A Homework 7 Problem A14.8 %
close all; clear all;

spacecraft_landing_data;

cvx_begin
    variables p(3,K+1) v(3,K+1) f(3,K)
    minimize sum(gamma*norms(f)*h)
    subject to
        p(:,1) == p0; v(:,1) == v0;
        v(:,2:K+1) == v(:,1:K) + (1/m)*f - ...
                    g*[zeros(1,K);zeros(1,K);ones(1,K)];
        p(:,2:K+1) == p(:,1:K) + .5*(v(:,1:K) + v(:,2:K+1));
        p(3,:) >= alpha*norms(p(1:2,:));
        norms(f) <= Fmax;
        p(:,K+1) == 0;  v(:,K+1) == 0;
cvx_end
fuel_consumption = cvx_optval;
P = p; V = v; F = f;

% use the following code to plot your trajectories
% plot the glide cone (don't modify)
% -------------------------------------------------------
 x = linspace(-40,55,30); y = linspace(0,55,30);
 [X,Y] = meshgrid(x,y);
 Z = alpha*sqrt(X.^2+Y.^2);
 figure; colormap autumn; surf(X,Y,Z);
 axis([-40,55,0,55,0,105]);
 grid on; hold on;

% INSERT YOUR VARIABLES HERE:
% -------------------------------------------------------
 plot3(P(1,:),P(2,:),P(3,:),'b','linewidth',1.5);
 quiver3(P(1,1:K),P(2,1:K),P(3,1:K),...
         F(1,:),F(2,:),F(3,:),0.3,'k','linewidth',1.5);
 title('Least Fuel-Consumption Solution');


% (b) %
% Feasibility problem %
while(true)
    K = K-1;
    cvx_begin quiet
    variables p(3,K+1) v(3,K+1) f(3,K)
    subject to
        p(:,1) == p0; v(:,1) == v0;
        v(:,2:K+1) == v(:,1:K) + (1/m)*f - ...
                    g*[zeros(1,K);zeros(1,K);ones(1,K)];
        p(:,2:K+1) == p(:,1:K) + .5*(v(:,1:K) + v(:,2:K+1));
        p(3,:) >= alpha*norms(p(1:2,:));
        norms(f) <= Fmax;
        p(:,K+1) == 0;  v(:,K+1) == 0;
    cvx_end
    if(strcmp(cvx_status,'Infeasible')),
        K = K+1;
        break;
    end
    P2 = p; V2 = v; F2 = f;
end
% use the following code to plot your trajectories
% plot the glide cone (don't modify)
% -------------------------------------------------------
 x = linspace(-40,55,30); y = linspace(0,55,30);
 [X,Y] = meshgrid(x,y);
 Z = alpha*sqrt(X.^2+Y.^2);
 figure; colormap autumn; surf(X,Y,Z);
 axis([-40,55,0,55,0,105]);
 grid on; hold on;

% INSERT YOUR VARIABLES HERE:
% -------------------------------------------------------
 plot3(P2(1,:),P2(2,:),P2(3,:),'b','linewidth',1.5);
 quiver3(P2(1,1:K),P2(2,1:K),P2(3,1:K),...
         F2(1,:),F2(2,:),F2(3,:),0.3,'k','linewidth',1.5);
 title('Least Time Solution');