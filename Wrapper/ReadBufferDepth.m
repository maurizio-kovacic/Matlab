function [DData] = ReadBufferDepth(h,MData,PData)
if(isfigure(h))
    ax = get_axes(h);
end
if( isaxes(h) )
    ax = h;
    h = ax.Parent;
end
if((nargin<3)||isempty(PData))
    p = get_patch(ax);
    Min = min(p.Vertices);
    Max = max(p.Vertices);
    PData = color2position(color2double(BufferPosition(h)),Min,Max);
end
if((nargin<2)||isempty(MData))
    MData = BufferMask(h);
end

X = campos(ax);
C = [repmat(repelem(ax.ZLim',4,1),1,1),...
     repmat(repelem(ax.YLim',2,1),2,1),...
     repmat(repelem(ax.ZLim',1,1),4,1)];
% D = vecnorm3(X-C);

X = reshape(X,1,1,3);
DData = (MData) .* sum((PData-X).^2,3);
DData(DData==0) = minimum(DData);
DData = (MData) .* normalize(DData) + (~MData) .* ones(size(MData));
% DData = (MData) .* normalize(sum((PData-X).^2,3),min(D),max(D)) + ...
%         (~MData) .* ones(size(MData));
end