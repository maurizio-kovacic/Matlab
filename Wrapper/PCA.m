function [ B, U, V, W ] = PCA( P )
B = barycenter( P );
M = P - repmat(B, size(P,1),1);
C = M'*M;
[~,~,V] = svd(C);
U = V(:,1)';
W = V(:,3)';
V = V(:,2)';
end