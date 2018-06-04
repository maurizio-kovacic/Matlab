function [N] = vertex_normal(P,T,type)
if( nargin < 3 )
    type = 'avg';
end
NT = triangle_normal(P,T);
if( strcmp( type, 'avg' ) )
    W = ones(size(T,1),1);
end
if( strcmp( type, 'area' ) )
    W = triangle_area(P,T);
end
N = normr( face2vertex(NT,T,W) );
end