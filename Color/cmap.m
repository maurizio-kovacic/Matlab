function c = cmap(data,resolution,iso,color,varargin)
    c = colormap(data,varargin{1:end});
    if( nargin < 4 )
        color = [0 0 0];
    end
    if( nargin < 3 )
        iso = 0;
    end
    if( nargin < 2 )
        resolution = size(c,1);
    end
    if( resolution ~= size(c,1) )
        c = interp1(linspace(0,1,size(c,1))',c,linspace(0,1,resolution));
    end
    c = colormap(c);
    if( iso > 0 )
        c = colormap(isolines(c,iso,color));
    end
end