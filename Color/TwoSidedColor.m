classdef TwoSidedColor < AbstractViewDependentColor
    properties
        N
    end
    
    methods( Access = public )
        function [obj] = TwoSidedColor(varargin)
            parser = inputParser;
            addRequired( parser, 'Parent', @(h) ispatch(h) );
            addOptional( parser, 'FrontColor', [1 0 0], @(c) (col(c)==3)&&(row(c)==1) );
            addOptional( parser, 'BackColor',  [0 0 1], @(c) (col(c)==3)&&(row(c)==1) );
            parse(parser,varargin{:});
            obj@AbstractViewDependentColor(parser.Results.Parent); 
            caxis(obj.Axes,[-1 1]);
            obj.Parent.BackFaceLighting = 'reverselit';
            obj.N                       = obj.Parent.VertexNormals;
            obj.CData = [parser.Results.FrontColor;parser.Results.BackColor];
        end

    end
    
    methods( Access = public, Sealed = true )
        function [Output] = viewOperation(obj,viewDirection)
            Output = sum(viewDirection.*obj.N,2);
            obj.Parent.VertexNormals(Output<=0,:) = -obj.N(Output<=0,:);
        end
    end
end