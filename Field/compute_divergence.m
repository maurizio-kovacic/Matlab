function [ D ] = compute_divergence( P, T, G )
n = size(P,1);
I = T(:,1);
J = T(:,2);
K = T(:,3);
Eij = P(J,:)-P(I,:);
Ejk = P(K,:)-P(J,:);
Eki = P(I,:)-P(K,:);   
[CTi, CTj, CTk] = triangle_cotangent(P,T);
Di = accumarray(I, ( CTk .* ( dot( Eij, G, 2 ) ) ) + ( CTj .* ( dot( -Eki, G, 2 ) ) ), [n 1] );
Dj = accumarray(J, ( CTi .* ( dot( Ejk, G, 2 ) ) ) + ( CTk .* ( dot( -Eij, G, 2 ) ) ), [n 1] );
Dk = accumarray(K, ( CTj .* ( dot( Eki, G, 2 ) ) ) + ( CTi .* ( dot( -Ejk, G, 2 ) ) ), [n 1] );
D = ( Di + Dj + Dk ) * 0.5;
end