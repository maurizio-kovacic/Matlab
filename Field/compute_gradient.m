function [ G ] = compute_gradient( P, T, F )
I   = T(:,1);
J   = T(:,2);
K   = T(:,3);
Eij = P(J,:)-P(I,:);
Ejk = P(K,:)-P(J,:);
Eki = P(I,:)-P(K,:);
N   = normr( cross(Eij, -Eki, 2) );
A   = triangle_area( P, T );
dF  = (  ...
        ( F(I) .* cross(N, Ejk, 2) ) + ...
        ( F(J) .* cross(N, Eki, 2) ) + ...
        ( F(K) .* cross(N, Eij, 2) ) ...
      ) ...
     ./ ( 2 * A );
G   = full(normr(-dF));
ID = find( (F(I)==F(J)) & (F(J)==F(K)) );
G(ID,:) = zeros(numel(ID),3);
end