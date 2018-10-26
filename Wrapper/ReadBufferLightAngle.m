function [NData] = ReadBufferLightAngle(h)
if(isfigure(h))
    ax = get_axes(h);
end
if( isaxes(h) )
    ax = h;
    h = ax.Parent;
end

p = get_patch(ax);
l = get_light(ax);

GraphicsSmoothing = h.GraphicsSmoothing;
Visible           = l.Visible;
FaceColor         = p.FaceColor;
FaceVertexCData   = p.FaceVertexCData;

h.GraphicsSmoothing = 'off';
l.Visible           = 'off';
p.FaceColor         = 'interp';
p.FaceVertexCData   = dot(normr(l.Position-p.Vertices),p.VertexNormals,2);
% drawnow;

NData = getframe(h);
NData = NData.cdata;

h.GraphicsSmoothing = GraphicsSmoothing;
l.Visible           = Visible;
p.FaceColor         = FaceColor;
p.FaceVertexCData   = FaceVertexCData;
% drawnow;
end