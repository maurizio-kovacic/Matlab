function [C] = color_ramp(CData,CRes,isoline,CIso,varargin)
if( nargin < 4 )
    CIso = [0 0 0];
end
if( nargin < 3 )
    isoline = false;
end
if( nargin < 2 )
    CRes = 64;
end
if( isoline )
    delta = 16;
    C = repelem(color_gradient(CData,10,varargin{:}),delta,1);
    i = setdiff((1:delta:row(C))',[1,row(C)]);
    C(i,:) = repmat(CIso,numel(i),1);
else
    C = color_gradient(CData,CRes,varargin{:});
end
end