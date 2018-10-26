function [h] = DisplayWireframe(h,CData)
if((nargin<2)||isempty(CData))
    CData = [0 0 0];
end
h.Marker    = 'none';
h.FaceColor = 'none';
h.EdgeColor = CData;
end