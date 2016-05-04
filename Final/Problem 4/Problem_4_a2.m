% EE 364A Final Problem 4 %
close all; clear all;

multi_label_svm_data;

Mu = logspace(-2,2,10);
r = 1:K';

for i = 1:K,
    X{i} = x(:,y==i);
end

