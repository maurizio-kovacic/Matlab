function [CData] = ReadBufferMask(h)
if(isfigure(h))
    ax = get_axes(h);
end
if( isaxes(h) )
    ax = h;
    h = ax.Parent;
end

p = get_patch(ax);
% l = get_light(ax);

GraphicsSmoothing = h.GraphicsSmoothing;
% Visible           = l.Visible;
FaceColor         = p.FaceColor;
FaceVertexCData   = p.FaceVertexCData;
FaceLighting      = p.FaceLighting;

h.GraphicsSmoothing = 'off';
% l.Visible           = 'off';
p.FaceColor         = 'interp';
p.FaceVertexCData   = zeros(size(p.Vertices));
p.FaceLighting      = 'none';
% drawnow;

CData = getframe(h);
CData = ~logical(sum(double(CData.cdata),3));

h.GraphicsSmoothing = GraphicsSmoothing;
% l.Visible           = Visible;
p.FaceColor         = FaceColor;
p.FaceVertexCData   = FaceVertexCData;
p.FaceLighting      = FaceLighting;
% drawnow;
end