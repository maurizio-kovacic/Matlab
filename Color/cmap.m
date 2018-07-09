function [C] = cmap(CData,CRes,isoline,CIso,varargin)
if( nargin < 4 )
    CIso = [0 0 0];
end
if( nargin < 3 )
    isoline = false;
end
if( nargin < 2 )
    CRes = 64;
end
if( ischar(CData) || isstring(CData) )
    p = color_palette(CData);
    if(~isempty(p))
        CData = p;
    else
        CData = colormap(CData);
    end
end
C = colormap(clamp(color_ramp(CData,CRes,isoline,CIso,varargin{:}),0,1));
end