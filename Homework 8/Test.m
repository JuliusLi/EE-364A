% EE 364A 2013 Practice Final Problem 3 %
close all; clear all;

gen_add_reg_data;

XX = X;
for i = 1:K,
    XX = [XX,max(X-p(i),0)+min(p(i),0)];
end

cvx_begin
    variables a c(n*(K+1))
    minimize 1/N * sum_square(y-a-XX*c) + lambda*norm(c,1)
cvx_end


xx=linspace(-10,10,1024);
yy=zeros(9,1024);
figure
for jj=1:9
    yy(jj,:)=c(jj)*xx;
    for ii=1:K
        yy(jj,:)=yy(jj,:)+c(ii*9+jj)*(pos(xx-p(ii))-pos(-p(ii)));
    end
    subplot(3,3,jj);
    plot(xx,yy(jj,:));
    hold on;
    plot(xx,f{jj}(xx),'r')
end