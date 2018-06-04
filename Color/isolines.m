function [c] = isolines( c, res, color )
if( nargin < 3 )
    color = [0 0 0];
end
i = (1:size(c,1)/res:size(c,1))';
if( size(color,1) == 1 )
    color = repmat(color,numel(i),1);
end
c(i,:) = color;
end