function [P,N,UV,T,varargout] = mesh2soup(P,N,UV,T,varargin)
n = col(T);
v = reshape(T',numel(T),1);
P = P(v,:);
N = N(v,:);
UV = UV(v,:);
T = reshape((1:row(P))',n,numel(v)/n)';
if( nargin >= nargout )
    if( nargout >= 5 )
        for i = 1 : (nargout-4)
            varargout{i} = varargin{i}(v,:);
        end
    end
end
end