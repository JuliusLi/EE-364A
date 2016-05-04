% EE 364A Final Problem 2 %
close all; clear all;

a = 2;  b = 3;
theta = [.05    .1   .3];
alpha = [-.1    .8  -.3];
beta  = [1.4   -.3   .7]; 

% Group j Maximal emotional state %
Aopt = [];
Topt = [];
sopt = [];
for j = 1:3,
    th = theta(j); be = beta(j); al = alpha(j);
    cvx_begin
        variables A(20) T(20) s(20)
        maximize s(20)
        subject to
            A(1:b) == zeros(b,1);
            T(1:b) == ones(b,1);
            A >= 0;     T >= 0;
            A + T == ones(20,1);
            for i = 4:20,
                sum(A(1:i)) <= a*(sum(T(1:i))-b);
            end
            
        % Initialization for s(0) = 0. %
            s(1) == th*(al*T(1)+be*A(1));
            for i = 2:20,
                s(i) == (1-th)*s(i-1) + ...
                    th*(al*T(i)+be*A(i));
            end
    cvx_end
    Aopt = [Aopt A];
    Topt = [Topt T];
    sopt = [sopt s];
end


% Maximum Minimum emotional state %
th1 = theta(1); th2 = theta(2); th3 = theta(3);
al1 = alpha(1); al2 = alpha(2); al3 = alpha(3);
be1 = beta(1); be2 = beta(2); be3 = beta(3);
cvx_begin
    variables A(20) T(20) s(20,3)
    maximize min(s(20,:))
    subject to
        A(1:b) == zeros(b,1);
        T(1:b) == ones(b,1);
        A >= 0;     T >= 0;
        A + T == ones(20,1);
        for i = 4:20,
            sum(A(1:i)) <= a*(sum(T(1:i))-b);
        end
    % Initialization for s(0) = 0. %
        s(1,1) == th1*(al1*T(1)+be1*A(1));
        s(1,2) == th2*(al2*T(1)+be2*A(1));
        s(1,3) == th3*(al3*T(1)+be3*A(1));
        for i = 2:20,
            s(i,1) == (1-th1)*s(i-1,1) + ...
                th1*(al1*T(i)+be1*A(i));
            s(i,2) == (1-th2)*s(i-1,2) + ...
                th2*(al2*T(i)+be2*A(i));
            s(i,3) == (1-th3)*s(i-1,3) + ...
                th3*(al3*T(i)+be3*A(i));
        end
cvx_end
Aopt = [Aopt A];
Topt = [Topt T];

% Generating plots %
for i = 1:3,
    subplot(4,2,2*(i-1) + 1);
        plot(1:20,Aopt(:,i),'b'); hold on;
        plot(1:20,Topt(:,i),'r');
    subplot(4,2,2*(i-1)+2);
        plot(1:20,sopt(:,i));
end

subplot(4,2,7);
    plot(1:20,Aopt(:,4),'b'); hold on;
    plot(1:20,Topt(:,4),'r');
subplot(4,2,8);
    plot(1:20,s(:,1),'b'); hold on;
    plot(1:20,s(:,2),'r'); hold on;
    plot(1:20,s(:,3),'k');
    



