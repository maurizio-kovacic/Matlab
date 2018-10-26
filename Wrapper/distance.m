function [D] = distance(A,B,p)
if((nargin<3)||isempty(p))
    p = 2;
end
D = vecnorm(A-B,p,2);
end