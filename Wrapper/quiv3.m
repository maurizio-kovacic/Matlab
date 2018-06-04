function [h] = quiv3( P,N, varargin )
h = quiver3(P(:,1),P(:,2),P(:,3),N(:,1),N(:,2),N(:,3),varargin{1:end});
end