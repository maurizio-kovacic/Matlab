function P = make_permutation(I,N)
x = zeros(N,1);
x(I) = 1;
x1 = cumsum(1-x) .* (1-x);
x2 = (max(x1)+cumsum(x)) .* x;
P = speye(N,N);
P = P(:,x1+x2);
end