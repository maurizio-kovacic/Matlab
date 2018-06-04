function [V] = normalize(U,m,M)
if( nargin < 3 )
    M = max(U);
end
if( nargin < 2 )
    m = min(U);
end
V = (U-m)./(M-m);
end