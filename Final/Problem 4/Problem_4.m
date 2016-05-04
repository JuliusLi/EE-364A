% EE 364A Final Problem 4 %
close all; clear all;

multi_label_svm_data;

Mu = logspace(-2,2,10);
r = 1:K';

for i = 1:K,
    X{i} = x(:,y==i);
    Y{i} = x(:,y~=i);
end

E = [];
for mu = Mu,
    mu
    A = []; B = [];
    for i = 1:K
        i
        xx = X{i};      yy = Y{i};
        N = size(xx,2); M = size(yy,2);
        cvx_begin quiet
            variables a(n) b u(N) v(M)
            minimize mu*square_pos(norm(a,2)) + sum(u) + sum(v)
            subject to
                sum(b) == 0; u>=0; v>=0;
                for j = 1:N,
                    a'*xx(:,j) - b >= 1-u(j);
                end
                for j = 1:M,
                    a'*yy(:,j) - b <= -(1-v(j));
                end
        cvx_end
        A = [A; a'];
        B = [B; b];
    end
    yest = [];
    for i = 1:mTest,
        yest = [yest find((A*x(:,i)+b) == max(A*x(:,i)+b))];
    end
    error_rate = mean(yest ~= ytest);
    E = [E,error_rate];
end
semilogx(Mu,E);


%{
cvx_begin
    variables A(K,n) b(K) u(K,K)
    minimize sum(sum(u)) + mu*square_pos(norm(A,'fro'))
    subject to
        u >= 0; sum(b) == 0;
        for j = 1:K,
            xx = X{j};
            yy = Y{j};
            for i = 1:size(xx,2),
                A(j,:)*xx(:,i) + b(j) >= 1-u(j,j);
            end
            for i = 1:size(yy,2),
                A(r~=j,:)*yy(:,i) + b(r~=j) <= -(1-u(r~=j,j));
            end
        end
cvx_end
yest = [];
for i = 1:mTest,
    yest = [yest find((A*x(:,i)+b) == max(A*x(:,i)+b))];
end
error_rate = mean(yest ~= ytest);        

%}

%{
    cvx_begin
        variables A(K,n) b(K)
        variable gam
            L = 0;
            for i = 1:mTrain,
                new = max(A(1:K~=y(i),:)*x(:,i) + b(1:K~=y(i)));
                new = new + 1 - A(y(i),:)*x(:,i) - b(y(i));
                new = pos(new);
                L = L+new;
            end
        minimize gam + mu*square_pos(norm(A,'fro'))
        subject to
            L <= gam;
            sum(b) == 0;
    cvx_end
    yest = [];
    for i = 1:mTest,
        yest = [yest find((A*x(:,i)+b) == max(A*x(:,i)+b))];
    end
    error_rate = mean(yest ~= ytest);

%}