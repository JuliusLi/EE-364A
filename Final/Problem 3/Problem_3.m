% EE 364A Final Problem 3 %
close all; clear all;

ac_motor_data;

Pout = omega*tau_des;
%K = [K K(:,1)];

cvx_begin
    variables V(3,N+1) I(3,N+1)
    Ploss = 0;
    for j = 1:N,
        Ploss = Ploss + (1/N)*I(:,j)'*R*I(:,j);
    end
    minimize Ploss
    subject to
        for j = 1:N,
            V(:,j) == R*I(:,j) + ...
                omega/h*L*(I(:,j+1)-I(:,j)) + omega*K(:,j);
        end
        I(:,1) == I(:,N+1);
        V <= V_supply;
        V >= -V_supply;
cvx_end
efficiency = Pout/(Pout + cvx_optval);

subplot(121);
    plot(1:N, I(1,1:N),'k'); hold on;
    plot(1:N, I(2,1:N),'b');
    plot(1:N, I(3,1:N),'r');
subplot(122);
    plot(1:N, V(1,1:N),'k'); hold on;
    plot(1:N, V(2,1:N),'b');
    plot(1:N, V(3,1:N),'r');
    