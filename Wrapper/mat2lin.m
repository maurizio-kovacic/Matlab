function [V] = mat2lin(M)
f = @(d,n) d(1:n);
V = f(M',numel(M)-col(M));
end