function [h] = path3(P,color,varargin)
if( nargin < 2 )
    color = [1 0 0];
end
h = line3([P(1:end-1,:) P(2:end,:)],'Color',color,'LineWidth',2,'Marker','o','MarkerFaceColor','auto',varargin{1:end});
end