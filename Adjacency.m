function [ A ] = Adjacency( P, T, type, varargin )
if( size(T,2) == 3 )
    n = size(P,1);
    I = T(:,1);
    J = T(:,2);
    K = T(:,3);
else
    n = P;
end
A = sparse( n , n );
if( strcmp( type, 'comb' ) || strcmp( type, 'cosine' ) || strcmp( type, 'length' ) )
    if( size(T,2) == 3 )
        E = unique( sortrows( sort( [I J; J K; K I], 2 ) ), 'rows' );
        E = [E(:,1) E(:,2); E(:,2) E(:,1)];
    else
        E = T;
    end
    if( strcmp( type, 'comb' ) )
        A = sparse( E(:,1), E(:,2), 1, n, n );
        return;
    end
    if( strcmp( type, 'cosine' ) ) 
        N = varargin{1};
        A = sparse( E(:,1), E(:,2), dot(N(E(:,1),:),N(E(:,2),:),2), n, n );
        return
    end
    if( strcmp( type, 'length' ) ) 
        A = sparse( E(:,1), E(:,2), vecnorm3(P(E(:,1),:)-P(E(:,2),:)), n, n );
        return;
    end
end

if( strcmp( type, 'cot' ) ) 
    [CTi, CTj, CTk] = triangle_cotangent(P,T);
    A = 0.5 * sparse([I;J;K;J;K;I],[J;K;I;I;J;K],[CTk;CTi;CTj;CTk;CTi;CTj],n,n);
    return
end

if( strcmp( type, 'face' ) )
    F = repmat((1:size(T,1))',3,1);
    [E, ~, ie] = unique( sort( [I J; J K; K I], 2 ), 'rows' );
    E = (1:size(E,1))';
    A = sparse(E(ie),F,1,numel(E),size(T,1));
    A = A'*A;
    A(1:size(T,1)+1:end)=0;
    return
end

if( strcmp( type, 'skin' ) )
    E = unique( sortrows( sort( [I J; J K; K I], 2 ) ), 'rows' );
    E = [E(:,1) E(:,2); E(:,2) E(:,1)];
    A = sparse( E(:,1), E(:,2), vecnorm(varargin{1}(E(:,1),:)-varargin{1}(E(:,2),:),2,2), n, n );
end

if( strcmp( type, 'deform' ) )
    d = skinning_regions(varargin{1});
    E = unique( sortrows( sort( [d(I) d(J); d(J) d(K); d(K) d(I)], 2 ) ), 'rows' );
    E = [E(:,1) E(:,2); E(:,2) E(:,1)];
    A = sparse( E(:,1), E(:,2), 1, size(varargin{1},2), size(varargin{1},2) );
end


end