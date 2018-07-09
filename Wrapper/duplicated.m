function [V,varargout] = duplicated(V,varargin)
i = (1:numel(V))';
[~,I] = unique(V,varargin{:});
I = setdiff(i,I);
V = V(I);
if( nargout >= 2 )
    varargout{1} = I;
end
end