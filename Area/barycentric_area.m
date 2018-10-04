function [ A ] = barycentric_area( P, T )
n = size(P,1);
[I,J,K] = tri2ind(T);
a = triangle_area( P, T ) / 3;
A = sparse( [I;J;K], [I;J;K], [a;a;a], n, n );
end