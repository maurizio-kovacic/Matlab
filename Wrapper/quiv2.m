function [h] = quiv2( P,N, varargin )
h = quiver3(P(:,1),P(:,2),N(:,1),N(:,2),varargin{1:end});
end