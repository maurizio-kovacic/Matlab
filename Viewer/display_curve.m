function [h] = display_curve(P,E,varargin)
h = patch('Faces',edge2tri(E),'Vertices',P,'FaceColor','none',...
          'FaceLighting','none','EdgeColor','r','LineWidth',2,varargin{:});
end