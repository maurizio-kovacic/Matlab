function [G] = color_gradient(C,n,method)
if( nargin < 3 )
    method = 'linear';
end
t = linspace(0,1,row(C))';
n = linspace(0,1,n)';
G = interp1(t,C,n,method);
end