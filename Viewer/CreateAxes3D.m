function [ax] = CreateAxes3D(h)
if( nargin == 0 )
    h = axes;
end
NA = {'Color',...
      'Box',...
      'XColor',...
      'YColor',...
      'ZColor',...
      'XGrid',...
      'YGrid',...
      'ZGrid',...
      'GridLineStyle',...
      'XTick',...
      'YTick',...
      'ZTick',...
      'XMinorTick',...
      'YMinorTick',...
      'ZMinorTick',...
      'Clipping',...
      'Projection'};
VA = {'none',...
      'off',...
      'none',...
      'none',...
      'none',...
      'off',...
      'off',...
      'off',...
      'none',...
      [],...
      [],...
      [],...
      'off',...
      'off',...
      'off',...
      'off',...
      'perspective'};
if( isfigure(h) )
    ax = axes(  h, NA, VA );
end
if( isaxes(h) )
    ax = set( h, NA, VA );
end
axis equal;
axis vis3d;
axis tight;
end
