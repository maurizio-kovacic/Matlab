function [CData] = ReadBufferColor(h)
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

h.GraphicsSmoothing = 'off';
p.FaceLighting      = 'none';

CData = getframe(h);
CData = CData.cdata;

h.GraphicsSmoothing = GraphicsSmoothing;
p.FaceLighting      = FaceLighting;
end