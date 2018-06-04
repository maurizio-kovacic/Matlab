function [ D ] = point_plane_distance( P, N, Q )
if( size(P,1) == size(Q,1) )
    V = Q - P;
    D = dot( V, N, 2 );
else
    if( size(P,1) < size(Q,1) )
        V = Q - repmat(P,size(Q,1),1);
        D = dot( V, repmat(N,size(Q,1),1), 2 );
    else
        V = repmat(Q,size(P,1),1) - P;
        D = dot( V, N, 2 );
    end
end
end