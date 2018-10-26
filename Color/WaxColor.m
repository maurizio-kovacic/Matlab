classdef WaxColor < AbstractViewDependentColor
    methods( Access = public )
        function [obj] = WaxColor(varargin)
            obj@AbstractViewDependentColor(varargin{1});
            obj.Parent.FaceLighting             = 'phong';
            obj.Parent.SpecularStrength         = 1;
            obj.Parent.SpecularColorReflectance = 0;
            obj.Parent.SpecularExponent         = 100;
            caxis(obj.Axes,[-1 1]);
            CRes = 256;
            if(nargin>=2)
                if(isstring(varargin{2})||ischar(varargin{2}))
                    obj.CData = color_palette(varargin{2});
                else
                    obj.CData = varargin{2};
                end
            else
                obj.CData = color_palette('r');
            end
            obj.CData = color_gradient(obj.CData,4);
            obj.CData = [obj.CData;repmat(obj.CData(end,:),row(obj.CData),1)];
            obj.CData = matresize(obj.CData,[CRes 3],'nearest');
        end

    end
    
    methods( Access = public, Sealed = true )
        function [Output] = viewOperation(obj,viewDirection)
            Output = sum(viewDirection.*obj.Parent.VertexNormals,2);
        end
    end
end