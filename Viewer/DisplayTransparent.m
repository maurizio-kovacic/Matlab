function [h] = DisplayTransparent(h,AData)
switch row(AData)
    case 1
        h.FaceAlpha           = AData;
    case row(h.Faces)
        h.FaceAlpha           = 'flat';
        h.FaceVertexAlphaData = AData;
    case row(h.Vertices)
        h.FaceAlpha           = 'interp';
        h.FaceVertexAlphaData = AData;
    otherwise
        disp('Wrong data dimension');
end
end