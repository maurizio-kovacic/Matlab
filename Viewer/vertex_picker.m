function vertex_picker(P,T)
CreateViewer3D();
fig = display_mesh(P,zeros(size(P)),T,[0.5 0.5 0.5],'wired');
fig.HandleVisibility = 'off';
set(fig,'ButtonDownFcn',@(object,event) vertex_picker_handler(object,event,P));
end


function vertex_picker_handler(object,event,P)
persistent ball;
if( ~isempty(ball) )
    delete(ball);
end
p = event.IntersectionPoint;
d = vecnorm3(P-p);
[~,i] = min(d);
hold on;
ball = point3(P(i,:),20,'r','filled');
hold off;
disp(['Vertex#: ', num2str(i)]);
disp(['Pos.   : ', num2str(P(i,:))]);
disp(['Clicked: ', num2str(p)]);
end