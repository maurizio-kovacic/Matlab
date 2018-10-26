classdef AbstractViewDependentColor < AbstractColor
    properties( Access = protected )
        Axes
    end
    
    properties( Access = private, Hidden = true )
        ParentListener
        AxesListener
    end
    
    methods( Access = public )
        function [obj] = AbstractViewDependentColor(varargin)
            obj@AbstractColor(varargin{:}); 
            obj.Axes = obj.Parent.Parent;
            obj.ParentListener =...
                addlistener(obj,...
                            'Parent','PostSet',...
                            @(varargin) set(obj.Axes,obj.Parent.Parent));
            obj.AxesListener =...
                addlistener(obj.Axes,...
                            'CameraPosition','PostSet',...
                            @(varargin) obj.update());
        end
        
        function delete(obj)
            delete@AbstractColor(obj);
            delete(obj.ParentListener);
            delete(obj.AxesListener);
        end
    end
        
    methods( Access = public, Sealed = true )
        function update(obj)
            if(isempty(obj.Parent))
               return;
            end 
            out = obj.viewOperation(obj.view_direction());
            if(row(out)==row(obj.Parent.Vertices))
                obj.Parent.FaceColor       = 'interp';
                obj.Parent.FaceVertexCData = out;
            else
                obj.Parent.FaceColor       = 'flat';
                obj.Parent.FaceVertexCData = out;
            end
            colormap(obj.Axes,obj.CData);
        end
    end
    
    methods( Access = public, Abstract )
        [Output] = viewOperation(obj,viewDirection)
    end
    
    methods( Access = private, Hidden = true, Sealed = true )
        function [D] = view_direction(obj)
            D = normr(obj.Axes.CameraTarget-obj.Axes.CameraPosition);
        end
    end
end