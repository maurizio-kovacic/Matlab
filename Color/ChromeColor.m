classdef ChromeColor < AbstractViewDependentColor
    methods( Access = public )
        function [obj] = ChromeColor(varargin)
            obj@AbstractViewDependentColor(varargin{1}); 
            obj.Parent.FaceLighting = 'phong';
            caxis(obj.Axes,[-1 1]);
            if(nargin>=2)
                if(isstring(varargin{2})||ischar(varargin{2}))
                    cdata = eval(strcat(varargin{2},'Chrome(256)'));
                else
                    cdata = varargin{2} .* chrome_effect(row(varargin{2}));
                end
            else
                cdata = GreenChrome(256);
            end
            obj.CData = clamp(cdata,[0 0 0],[1 1 1]);
        end

    end
    
    methods( Access = public, Sealed = true )
        function [Output] = viewOperation(obj,viewDirection)
            Output = sum(viewDirection.*obj.Parent.VertexNormals,2);
        end
    end
end