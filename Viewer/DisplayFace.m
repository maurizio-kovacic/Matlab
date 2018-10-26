function [h] = DisplayFace(h,CData)
if((nargin<2)||isempty(CData))
    CData = [1 1 1];
end
h.Marker    = 'none';
h.EdgeColor = 'none';
DisplayColor(h,CData);
end