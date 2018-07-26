function GeodesicDistanceViewer3D(P,N,T)
[A,t,L,~] = heat_diffusion_data(P,T,[]);
Ill       = 0.0001*speye(row(P));
AtL       = decomposition(A+t*L+Ill);
L         = decomposition(L+Ill);
clear Ill A t;

CreateViewer3D('Name','Geodesic Distance Viewer','right');
fig = display_mesh(P,N,T,[0.5 0.5 0.5]);
cmap('parula',[],true);
fig.HandleVisibility = 'off';
set(fig,'ButtonDownFcn',@(object,event) geodesic_field(object,event,P,T,AtL,L));
end

function geodesic_field(object,event,P,T,AtL,L)
persistent i;
persistent Pi;
delete(Pi);
x = find_closest_vertex(P,event.IntersectionPoint);
if(ismember(x,i))
    i = setdiff(i,x);
else
    i = [i;x];
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
    gu = normr(compute_gradient(P,T,u));
    du = compute_divergence(P,T,gu);
    u  = L\du;
    
    object.FaceColor       = 'interp';
    object.FaceVertexCData = u;
end
end

function [i] = find_closest_vertex(P,q)
D = vecnorm3(P-q);
[~,i] = min(D);
end