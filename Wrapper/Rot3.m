function [R] = Rot3(theta,dim)
if( nargin < 2 )
    dim = 1;
end
if( nargin < 1 )
    theta = pi/2;
end
c = cos(theta);
s = sin(theta);
if( dim == 1 )
    R = [1 0 0 0; 0 c -s 0; 0 s c 0; 0 0 0 1];
end
if( dim == 2 )
    R = [c 0 s 0; 0 1 0 0; -s 0 c 0; 0 0 0 1];
end
if( dim == 3 )
    R = [c -s 0 0; s c 0 0; 0 0 1 0; 0 0 0 1];
end
end