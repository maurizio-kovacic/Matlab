function [C] = implicit_field_color(CRes)
if( nargin == 0 || isempty(CRes) )
    CRes = 64;
end
if( CRes <= 0 )
    n = 64;
else
    n = CRes;
end
C              = zeros(n, 3);
C(1:floor(n/2),:)     = color_gradient([0.3 0.75 0.93;0.1 0.1 0.5],floor(n/2));
C(floor(n/2)+1:end,:) = color_gradient([0.5 0.1 0.1;1 0 0],ceil(n/2));
% C(1,:)         = [ 0 0 0 ];
% C(n/2+1,:)     = [ 0 1 0 ];
% C(n,:)         = [ 1 1 0 ];
end