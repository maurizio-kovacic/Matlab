function [B] = triangle_barycenter(P,T)
I = T(:,1);
J = T(:,2);
K = T(:,3);
Pi = P(I,:);
Pj = P(J,:);
Pk = P(K,:);
B = ( Pi + Pj + Pk ) ./ 3;
end