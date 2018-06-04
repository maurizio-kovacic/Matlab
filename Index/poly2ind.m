function [varargout] = poly2ind(P)
n = min([nargout size(P,2)]);
for i = 1 : n
    varargout{i} = P(:,i);
end
for i = i+1 : nargout
    varargout{i} = [];
end
end