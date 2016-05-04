% EE 364A Final Problem 6 %
close all; clear all;

wc_risk_portfolio_opt_data;
Swc_primer = diag(diag(Sigma));
for i = 1:n,
    for j = i+1:n,
        Swc_primer(i,j) = sqrt(Sigma(i,i)*Sigma(j,j));
        Swc_primer(j,i) = sqrt(Sigma(i,i)*Sigma(j,j));
    end
end

M = 2*(mu*mu'>= 0)-1;
Swc = M.*Swc_primer;

cvx_begin
    variable x(n)
    maximize (mu'*x);
    subject to
        x(mu>=0) >=0;   % Extra constraints added to ensure %
        x(mu<=0) <=0;   % risk was surely less than R_wc %
        x'*Sigma*x <= R;
        x'*Swc*x <= R_wc;
cvx_end
mean_return1 = cvx_optval;
Swc1 = (2*(x*x'>=0)-1).*Swc_primer;
WC_risk1 = x'*Swc1*x;


% When the worst case risk constraint is ignored %

cvx_begin
    variable x2(n)
    maximize (mu'*x2);
    subject to
        x2'*Sigma*x2 <= R;
cvx_end
mean_return2 = cvx_optval;
Swc2 = (2*(x2*x2'>=0)-1).*Swc_primer;
WC_risk2 = x2'*Swc2*x2;