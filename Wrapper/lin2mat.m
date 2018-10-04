function [M] = lin2mat(V)
n = ceil(sqrt(numel(V)));
M = reshape(V,[n n-1])';
M = [M; zeros(1,col(M)-1) 1];
end