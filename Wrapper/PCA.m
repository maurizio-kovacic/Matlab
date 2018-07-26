function [ B, varargout ] = PCA( P )
B = barycenter( P );
M = P - repmat(B, size(P,1),1);
C = M'*M;
[~,~,V] = svd(C);
V = V';
if( nargout == 2 )
    varargout{1} = V;
end
if( nargout >= 3 )
    varargout{1} = V(1,:);
    varargout{2} = V(2,:);
end
if( nargout >= 4 )
    varargout{3} = V(3,:);
end
end