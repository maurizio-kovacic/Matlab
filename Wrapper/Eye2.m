function [I] = Eye2(n)
if( nargin < 1 )
    n = 1;
end
I = repmat([1 0 0 0 1 0 0 0 1],n,1);
end