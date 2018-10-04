function [ D ] = point_plane_distance( P, N, Q )
X = Q-P;
D = dot(repmat(N,1+abs(row(N)-row(X)),1),X,2);
end