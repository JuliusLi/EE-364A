function HD = hessi_diag(x, A)
    d = diag(1./(1-A*x))^2;
    vect = diag(A'*d*A) + 1./(1+x).^2 + 1./(1-x).^2; 
    HD = diag(vect);
end