% EE 364A Homework 8 Problem A3.28 %
close all; clear all;

cvx_begin
    variable p(2,2,2,2)
    minimize sum_all(p(:,:,:,2))
    subject to
        sum_all(p(2,:,:,:)) == .9;
        sum_all(p(:,2,:,:)) == .9;
        sum_all(p(:,:,2,:)) == .1;
        sum_all(p(2,:,2,1)) == .7*sum_all(p(:,:,2,:));
        sum_all(p(:,2,1,2)) == .6*sum_all(p(:,2,1,:));
        sum_all(p) == 1;
        p >= 0;
        p <= 1;
cvx_end