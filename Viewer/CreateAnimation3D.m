function [fig] = CreateAnimation3D(Skin,Anim,type)
clear SkinningStep;
if( nargin < 3 )
    type = 'CPS';
end
if( ~strcmp(upper(type),'CPS') && ~strcmp(upper(type),'LBS') && ~strcmp(upper(type),'DIV') )
    type = 'CPS';
end

fig = CreateViewer3D('right');
fig.Name = type;
display_mesh(Skin.M.P,Skin.M.N,Skin.M.S);

frame = uicontrol( fig,...
    'Style', 'slider',...
    'Position', [100, 10, 200, 20],...
    'Min', 1,...
    'Max', 100,...
    'SliderStep', [0.01 0.1],...
    'Value', 1);
addlistener( frame, 'ContinuousValueChange',...
             @(src,event) SkinningStep(fig,Skin,Anim{floor(src.Value)},type) );

end

