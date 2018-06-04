function [ L ] = Laplacian( A, type )
if( nargin < 3 )
    type = 'std';
end
D = Degree(A);
L = sparse(size(A));
if( strcmp( type, 'std' ) )
    L = D - A;
    return;
end
I  = speye(size(D));
iD = I ./ D;
if( strcmp( type, 'sym' ) )
    iD = sqrt( iD );
    L  = I - iD * A * iD;
    return;
end
if( strcmp( type, 'walk' ) )
    L  = iD * A;
end
end