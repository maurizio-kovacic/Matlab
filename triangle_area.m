function [ A ] = triangle_area( P , T )
I = T(:,1);
J = T(:,2);
K = T(:,3);
Eij = P(J,:)-P(I,:);
Eik = P(K,:)-P(I,:);
A = 0.5 * vecnorm3(cross(Eij, Eik, 2));
end