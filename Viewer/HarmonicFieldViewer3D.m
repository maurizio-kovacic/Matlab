function HarmonicFieldViewer3D(P,N,T)
L = cotangent_Laplacian(P,T);
CreateViewer3D('Name','Harmonic Field Viewer','right');
fig = display_mesh(P,N,T,[0.5 0.5 0.5]);
cmap('parula',[],true);
fig.HandleVisibility = 'off';
set(fig,'ButtonDownFcn',@(object,event) harmonic_field(object,event,P,L));
end

function harmonic_field(object,event,P,L)
persistent i j;
persistent Pi Pj;
x = find_closest_vertex(P,event.IntersectionPoint);
if strcmpi(get(get_patch_figure(object),'SelectionType'),'alt')
    if(ismember(x,j))
        j = setdiff(j,x);
    else
        j = [j;x];
    end
else
    if(ismember(x,i))
        i = setdiff(i,x);
    else
        i = [i;x];
    end
end
delete(Pi);
delete(Pj);
if( isempty([i;j]) )
    object.FaceColor       = [0.5 0.5 0.5];
    object.FaceVertexCData = [];
else
    hold on;
    Pi = point3(P(i,:),20,'r','filled');
    hold on;
    Pj = point3(P(j,:),20,'b','filled');
    
    M = add_constraints(L,[i;j],[]);
    k = zeros(row(P),1);
    k(i) = 1;
    u = M\k;
    object.FaceColor       = 'interp';
    object.FaceVertexCData = u;
end
end

function [i] = find_closest_vertex(P,q)
D = vecnorm3(P-q);
[~,i] = min(D);
end

function [h] = get_patch_figure(object)
h = get(get(object,'Parent'),'Parent');
end
