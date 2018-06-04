function [U] = face2vertex(V,T,W)
if( nargin < 3 )
    W = ones(3*size(T,1),1);
end
if( size(W,1) == size(T,1) )
    W = [W;W;W];
end
I = T(:,1);
J = T(:,2);
K = T(:,3);
WV = W .* [V;V;V];
S = accumarray([I;J;K],W);
U = accumarray3([I;J;K],WV) ./ S;
end