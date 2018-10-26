function [NData] = ReadBufferNormal(h)
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

h.GraphicsSmoothing = 'off';
p.FaceLighting      = 'none';
p.FaceColor         = 'interp';
p.FaceVertexCData   = normal2color(p.VertexNormals);

NData = getframe(h);
NData = NData.cdata;

h.GraphicsSmoothing = GraphicsSmoothing;
p.FaceLighting      = FaceLighting;
p.FaceColor         = FaceColor;
p.FaceVertexCData   = FaceVertexCData;
end