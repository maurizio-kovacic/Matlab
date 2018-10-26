classdef FlatColor < AbstractColor
    methods( Access = public )
        function [obj] = FlatColor(varargin)
            obj@AbstractColor(varargin{:});
            obj.update();
        end
    
        function update(obj)
            obj.Parent.FaceColor = 'flat';
            obj.Parent.FaceVertexCData = obj.CData;
        end
    end
end