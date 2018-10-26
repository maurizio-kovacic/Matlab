classdef SmoothColor < AbstractColor
    methods( Access = public )
        function [obj] = SmoothColor(varargin)
            obj@AbstractColor(varargin{:});
            obj.update();
        end
    
        function update(obj)
            obj.Parent.FaceColor = 'interp';
            obj.Parent.FaceVertexCData = obj.CData;
        end
    end
end