function [h] = DisplayColor(h,CData)
switch row(CData)
    case 1
        h.FaceColor       = CData;
    case row(h.Faces)
        h.FaceColor       = 'flat';
        h.FaceVertexCData = CData;
    case row(h.Vertices)
        h.FaceColor       = 'interp';
        h.FaceVertexCData = CData;
    otherwise
        disp('Wrong data dimension');
end
end