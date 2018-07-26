function HeatDiffusionViewer3D(P,N,T)
fig  = CreateViewer3D('Name','Heat Diffusion Viewer','right');
mesh = display_mesh(P,N,T,[0.5 0.5 0.5]);
cmap('king',256);
mesh.HandleVisibility = 'off';

slider = uicontrol( fig,...
    'Style', 'slider',...
    'Position', [100, 10, 200, 20],...
    'Min', 0,...
    'Max', mesh_scale(P),...
    'SliderStep', [0.001 0.1],...
    'Value', 0.1);
addlistener( slider, 'ContinuousValueChange',...
             @(object,event) heat_diffusion_field(mesh,[],P,T,slider.Value) );

set(mesh,'ButtonDownFcn',@(object,event) heat_diffusion_field(object,event,P,T,slider.Value));
end

function heat_diffusion_field(object,event,P,T,diffusion_time)
persistent i;
persistent Pi;
persistent A;
persistent L;
persistent t;
persistent AtL;
if( isempty(A) )
    A = barycentric_area(P,T);
end
if( isempty(L) )
    L = cotangent_Laplacian(P,T);
end
if( isempty(t) )
    t = 0;
end
if( t ~= diffusion_time )
    t   = diffusion_time;
    AtL = decomposition(A+t*L + 0.0001*speye(row(P)));
end
delete(Pi);

if( ~isempty(event) )
    x = find_closest_vertex(P,event.IntersectionPoint);
    if(ismember(x,i))
        i = setdiff(i,x);
    else
        i = [i;x];
    end
end
if( isempty(i) )
    object.FaceColor       = [0.5 0.5 0.5];
    object.FaceVertexCData = [];
else
    hold on;
    Pi = point3(P(i,:),20,'r','filled');
    
    k = zeros(row(P),1);
    k(i) = 1;
    
    u  = AtL\k;
    
    object.FaceColor       = 'interp';
    object.FaceVertexCData = u;
end
end

function [i] = find_closest_vertex(P,q)
D = vecnorm3(P-q);
[~,i] = min(D);
end