function [P] = color2position(C,Min,Max)
if( ~isdouble(C) )
    C = color2double(C);
end
if( nargin < 3 )
    Max = ones(1,3);
end
if( nargin < 2 )
    Min = -ones(1,3);
end
if( ndims(C) == 3 )
    Min = reshape(Min,1,1,3);
    Max = reshape(Max,1,1,3);
end
P = Min + C .* (Max-Min);
% if( ndims(C) == 3 )
%     P = reshape(permute(P,[2 1 3]),row(P)*col(P),3,1);
% end
end