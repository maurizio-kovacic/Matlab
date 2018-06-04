function [U] = vertex2face(V,T,W)
[I,J,K] = tri2ind(T);
if( nargin < 3 )
    W = ones(size(V,1),1);
end
Vi = V(I,:);
Vj = V(J,:);
Vk = V(K,:);
Wi = W(I,:);
Wj = W(J,:);
Wk = W(K,:);
U = (Wi.*Vi + Wj.*Vj + Wk.*Vk)./(Wi+Wj+Wk);
end