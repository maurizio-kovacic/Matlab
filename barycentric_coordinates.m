function [ B ] = barycentric_coordinates( P, T, Q )
B = zeros(size(Q,1),3);
I = T(:,1);
J = T(:,2);
K = T(:,3);
Ei = P(K,:) - P(I,:);
Ej = P(J,:) - P(I,:);
Ek = Q      - P(I,:);
Dii = dot( Ei, Ei, 2 );
Dij = dot( Ei, Ej, 2 );
Dik = dot( Ei, Ek, 2 );
Djj = dot( Ej, Ej, 2 );
Djk = dot( Ej, Ek, 2 );
d = 1 ./ ( Dii .* Djj - Dij .* Dij );
B(:,3) = (Djj .* Dik - Dij .* Djk) .* d;
B(:,2) = (Dii .* Djk - Dij .* Dik) .* d;
B(:,1) = 1 - B(:,2) - B(:,3);
end