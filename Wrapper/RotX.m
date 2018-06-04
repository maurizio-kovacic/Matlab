function [R] = RotX(theta)
R = [ 1 0 0 0 0 cos(theta) -sin(theta) 0 0 sin(theta) cos(theta) 0 ];
end