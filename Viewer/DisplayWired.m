function [h] = DisplayWired(h,CData)
if((nargin<2)||isempty(CData))
    CData = [0 0 0];
end
h.Marker    = 'none';
h.EdgeColor = CData;
end