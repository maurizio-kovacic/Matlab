function [L] = grid_combinatorial_Laplacian( rows, cols, degree, constraints_index )
e = @( i, n ) sparse( 1:numel(i) , i, 1, numel(i), n );
if( nargin < 4 )
    constraints_index = [];
end
if( nargin < 3 || degree < 1 )
    degree = 1;
end
[i,j] = meshgrid([1:rows]',[1:cols]');
E = cat(2,i',j');
E = reshape(E,[],2);
i = E(:,1);
j = E(:,2);
E = [i j i+1 j; i j i-1 j; i j i j+1; i j i j-1];
[x,~] = find( (E(:,3) <= 0) | (E(:,4) <= 0) | (E(:,3) > rows) | (E(:,4) > cols) );
E(x,:) = [];
E = [ sub2ind([rows cols], E(:,1), E(:,2) ) sub2ind([rows cols], E(:,3), E(:,4) ) ];
L = combinatorial_Laplacian(rows*cols,E);
L = L^degree;
if( ~isempty(constraints_index) )
    if( size(constraints_index,2) == 1 )
        x = constraints_index;
    else
        x = sub2ind([rows cols],constraints_index(:,1), constraints_index(:,2));
    end
    L(x,:) = e( x, rows*cols );
end
end