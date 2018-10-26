classdef CartoonColor < AbstractViewDependentColor
    methods( Access = public )
        function [obj] = CartoonColor(varargin)
            obj@AbstractViewDependentColor(varargin{1}); 
            obj.Parent.FaceLighting = 'none';
            cres = 256;
            if(nargin>=2)
                if(isstring(varargin{2})||ischar(varargin{2}))
                    cdata = flipud(color_palette(varargin{2}));
                else
                    cdata = varargin{2};
                end
            else
                cdata = flipud(color_palette('r'));
            end
            cdata = color_gradient(cdata,4);
            cdata = [cdata;repmat(cdata(end,:),row(cdata),1)];
            cdata = matresize(cdata,[cres 3],'nearest');
            cdata = cdata .* silhouette_effect(cres);
            caxis(obj.Axes,[-1 1]);
            obj.CData = cdata;
        end

    end
    
    methods( Access = public, Sealed = true )
        function [Output] = viewOperation(obj,viewDirection)
            Output = sum(viewDirection.*obj.Parent.VertexNormals,2);
        end
    end
end