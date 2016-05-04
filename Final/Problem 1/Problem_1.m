% EE 364A Final Problem 1 %
close all; clear all;

lightest_struct_data;

% Determine all bar lengths and directions %
L = []; d = [];
for i = 1:n,
    start = P(:,r(i));   finish = P(:,s(i));
    length = norm(start - finish, 2);
    L = [L; length];
    direction = start - finish;
    d = [d direction];
end
% Each force is then (t(j)/L(j))*d(:,j) %

% Form A matrix %
A = [];
for i = 1:n,
    a_i = (1:m == r(i)) - (1:m == s(i));
    A = [A; a_i];
end


% Solve the problem for V_star%
cvx_begin
    variables a(n) t(n,M)
    minimize  sum(a.*L)
    subject to
    % Constraints must be met for each set of loadings %
        for i = 1:M,
            t(:,i) <= sigma*a;
            t(:,i) >= -sigma*a;
            
        % Force balance constraint %
            G = zeros(2,m); % G is the 2xm matrix of forces %
            for j = 1:n,
                force_j = (t(j,i)/L(j))*d(:,j);
                acting_force_j = force_j*A(j,:);
                G = G + acting_force_j;
            end
            G(:,1:k) + F(:,:,i) == 0;
        end
cvx_end
V_star = cvx_optval;

% plot code is taken from lightest_struct_data.m as instructed %
clf; hold on;
for i = 1:n
    p1 = r(i); p2 = s(i);
    plt_str = 'b-';
    width = a(i);
    if a(i) < 0.001
        plt_str = 'r--';
        width = 1;
    end
    plot([P(1, p1) P(1, p2)], [P(2, p1) P(2, p2)], ...
         plt_str, 'LineWidth', width);
end
axis([-0.5 N-0.5 -0.1 N-0.5]); axis square; box on;
set(gca, 'xtick', [], 'ytick', []);

clear X Y dx dy ind px py plt_str p1 p2 i a;

% Solve the problem for V-unif %
cvx_begin
    variables a(n) t(n,M) constant
    minimize  sum(a.*L)
    subject to
        a == constant;  % Uniform cross-sectional area constraint %
    % Constraints must be met for each set of loadings %
        for i = 1:M,
            t(:,i) <= sigma*a;
            t(:,i) >= -sigma*a;
            
        % Force balance constraint %
            G = zeros(2,m); 
            % G is the 2xm matrix of forces excluding loads %
            for j = 1:n,
                force_j = (t(j,i)/L(j))*d(:,j);
                acting_force_j = force_j*A(j,:);
                G = G + acting_force_j;
            end
            G(:,1:k) + F(:,:,i) == 0;
        end
cvx_end
V_unif = cvx_optval;