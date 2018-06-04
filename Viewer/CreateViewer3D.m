function [h,varargout] = CreateViewer3D(varargin)
persistent l;
if( isempty(varargin) )
    pos = [];
else
    pos = varargin{end};
end
h = figure(varargin{1:end-1});
ax = CreateAxes3D(h);
if( ~isempty(pos) )
    l = camlight(pos);
    h.WindowButtonMotionFcn = @(obj,event) camlight(l,pos);
end
rotate3d on;
if( nargout >= 2 )
    varargout{1} = ax;
end
if( nargout >= 3 )
    varargout{2} = l;
end
end