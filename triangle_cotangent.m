function [CTi, CTj, CTk] = triangle_cotangent( P, T )
i = 1;
j = 2;
k = 3;
I = T(:,i);
J = T(:,j);
K = T(:,k);
Eij = P(J,:)-P(I,:);
Ejk = P(K,:)-P(J,:);
Eki = P(I,:)-P(K,:);
CTi = dot(Eij, -Eki, 2)./vecnorm3(cross(Eij, -Eki, 2));
CTj = dot(Ejk, -Eij, 2)./vecnorm3(cross(Ejk, -Eij, 2));
CTk = dot(Eki, -Ejk, 2)./vecnorm3(cross(Eki, -Ejk, 2));
end