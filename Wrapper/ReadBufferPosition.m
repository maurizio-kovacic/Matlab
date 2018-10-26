function [PData] = ReadBufferPosition(h,Min,Max)
if(isfigure(h))
    ax = get_axes(h);
end
if( isaxes(h) )
    ax = h;
    h = ax.Parent;
end
p = get_patch(ax);

GraphicsSmoothing = h.GraphicsSmoothing;
FaceLighting      = p.FaceLighting;
FaceColor         = p.FaceColor;
FaceVertexCData   = p.FaceVertexCData;

if(nargin<3||isempty(Max))
    Max = max(p.Vertices);
end
if(nargin<2||isempty(Min))
    Min = min(p.Vertices);
end

h.GraphicsSmoothing = 'off';
p.FaceLighting      = 'none';
p.FaceColor         = 'interp';
p.FaceVertexCData   = position2color(p.Vertices,Min,Max);

PData = getframe(h);
PData = PData.cdata;

h.GraphicsSmoothing = GraphicsSmoothing;
p.FaceLighting      = FaceLighting;
p.FaceColor         = FaceColor;
p.FaceVertexCData   = FaceVertexCData;
end