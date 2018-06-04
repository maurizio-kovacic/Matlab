function [F] = align_field(U,V,Adj,iteration)
if( nargin < 4 )
    iteration = 3;
end
if( isempty(V) )
    V = U;
end
F = U;
[I,J] = ind2sub(size(Adj),find(Adj));
for i = 1 : iteration
    W = dot(F(I,:),V(J,:),2);
    F = accumarray3(I,W.*V(J,:));
    S = accumarray(I,abs(W));
    F = normr(F./S);
end
end