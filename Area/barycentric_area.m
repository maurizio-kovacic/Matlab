function [ A ] = barycentric_area( P, T )
n = size(P,1);
I = T(:,1);
J = T(:,2);
K = T(:,3);
a = triangle_area( P, T ) / 3;
A = sparse( [I;J;K], [I;J;K], [a;a;a], n, n );
end