function [T] = Tra3(t,type)
T = [eye(4,3),[t,1]'];
if( nargin < 2 )
    type = 'linear';
end
if( strcmpi(type,'linear') )
    T = linearize_transformation_matrix(T);
end
end