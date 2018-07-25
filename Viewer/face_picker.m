function face_picker(P,T)
CreateViewer3D();
fig = display_mesh(P,zeros(size(P)),T,[0.5 0.5 0.5],'wired');
fig.HandleVisibility = 'off';
set(fig,'ButtonDownFcn',@(object,event) face_picker_handler(object,event,P,T));
end


function face_picker_handler(object,event,P,T)
persistent tri;
if( ~isempty(tri) )
    delete(tri);
end
p = event.IntersectionPoint;
X = triangle_barycenter(P,T);
d = vecnorm3(X-p);
[~,i] = min(d);
hold on;
tri = patch('Faces',T(i,:),'Vertices',P,'FaceColor','r');
hold off;
disp(['Face#  : ', num2str(i)]);
disp(['Vert.ID: ', num2str(T(i,:))]);
disp(['Clicked: ', num2str(p)]);
end