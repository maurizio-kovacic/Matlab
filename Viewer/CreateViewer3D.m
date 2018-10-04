function [fig,varargout] = CreateViewer3D(varargin)
if( isempty(varargin) )
    pos = [];
else
    pos = varargin{end};
end
fig = figure('Name','Viewer 3D','NumberTitle','off',varargin{1:end-1});
ax = figure_linear_gradient(fig);
uistack(ax,'bottom');
ax  = CreateAxes3D();
% if( ~isempty(pos) )
    set(fig,'WindowButtonMotionFcn',@(obj,event) update(obj,event,pos));
    set(fig,'WindowButtonDownFcn',@(obj,event) update(obj,event,pos));
    set(fig,'WindowButtonUpFcn',@(obj,event) update(obj,event,pos));
    set(fig,'WindowScrollWheelFcn',@(obj,event) update(obj,event,pos));
    update_light(fig,pos);
% end
set(fig,'KeyPressFcn',@KeyEventHandler);
% rotate3d on;
if( nargout >= 2 )
    varargout{1} = ax;
end
if( nargout >= 3 )
    varargout{2} = l;
end
end

function KeyEventHandler(object,event)
if(~isempty(get_patch(object)))
    if( strcmpi(event.Key,'x') )
        ExportMeshHandler(object);
    end
    if( strcmpi(event.Key,'i') )
        InfoMeshHandler(object);
    end
    if( strcmpi(event.Key,'n') )
        NormalHandler(object);
    end
    if( strcmpi(event.Key,'t') )
        TrueNormalHandler(object);
    end
end
end

function ExportMeshHandler(object)
persistent filter;
if(isempty(filter))
    filter = {'*.obj', 'Wavefront OBJ format'; ...
              '*.off', 'Object File Format'};
end

[name,path,idx] = uiputfile(filter,...
                            'Export Mesh...',...
                            'Untitled.obj');
if( name ~= 0 )
    name     = cell2mat(strrep(name,strrep(filter(idx,1),'*',''),''));
    filename = strcat(path,name);
    
    h  = get_patch(object);
    for i = 1 : numel(h)
        if( numel(h) == 1 )
            suffix = '';
        else
            suffix = strcat('_',num2str(i));
        end
        P  = h(i).Vertices;
        T  = h(i).Faces;
        switch( idx )
            case 1
                N  = h(i).VertexNormals;
                UV = zeros(row(P),2);
                export_OBJ( strcat(filename,suffix), P, N, UV, T );
            case 2
                export_OFF( strcat(filename,suffix), P, T );
            otherwise
                continue;
        end
    end
end
end


function update_light(object,position)
    if(isempty(position))
        return;
    end
    ax = get_axes(object);
    for i = 1 : numel(ax)
        l = get_light(ax(i));
        if( isempty(l) )
            camlight(ax(i),position);
        else
            arrayfun(@(h) camlight(h,position),l);
        end
    end
end


function InfoMeshHandler(object)
persistent info;
if(isempty(info))
    h = get_patch(object);
    nP = 0;
    nF = 0;
    for i = 1 : numel(h)
        nP = nP+row(h.Vertices);
        nF = nF+row(h.Faces);
    end
    info = annotation('textbox',...
                     'String',['#Vertices : ', num2str(nP);...
                               '#Faces    : ', num2str(nF)],...
                     'Position',[0 0 0.21 0.1],...
                     'FitBoxToText','off');
else
    delete(info);
    info = [];
end
end

function NormalHandler(object)
persistent n;
if(isempty(n))
    h = get_patch(object);
    P = [];
    N = [];
    if(numel(h)>0)
        for i = 1 : numel(h)
            P = [P;h(i).Vertices];
            N = [N;h(i).VertexNormals];
        end
        hold on;
        n = quiv3(P,N,'Color','b');
        hold off;
    end
else
    delete(n);
    n = [];
end
end

function TrueNormalHandler(object)
persistent n;
if(isempty(n))
    h = get_patch(object);
    if(numel(h)>0)
        for i = 1 : numel(h)
            P = h(i).Vertices;
            T = h(i).Faces;
            N = vertex_normal(P,T);
            hold on;
            n = quiv3(P,N,'Color','r');
            hold off;
        end
    end
else
    delete(n);
    n = [];
end
end

function [] = update(object,event,position)
persistent press;
persistent currentPos;
if(isempty(press))
    press = false;
end
update_light(object,position);
ax = get_axes(object);
switch event.EventName
    case 'WindowScrollWheel'
        s = 1-event.VerticalScrollCount*0.1;
        if( s <= 0 )
            return;
        end
        for i = 1 : numel(ax)
                camzoom(ax(i),s);
        end
    case 'WindowMousePress'
        press      = true;
        currentPos = object.CurrentPoint;
    case 'WindowMouseRelease'
        press = false;
    case 'WindowMouseMotion'
        if(press)
            p          = object.CurrentPoint;
            dp         = currentPos-p;
            currentPos = p;
            for i = 1 : numel(ax)
                camorbit(ax(i),dp(1),dp(2),'coordsys','camera');
            end
        end
    otherwise
        disp(event.EventName);
end
end