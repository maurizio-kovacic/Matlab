classdef AbstractColor < handle
    properties( Access = public, SetObservable )
        Parent
        CData
    end
    
    methods( Access = public )
        function [obj] = AbstractColor(varargin)
            parser = inputParser;
            addRequired( parser, 'Parent', @(h) ispatch(h) );
            addOptional( parser, 'CData', [1 1 1], @(c) (col(c)==3)||(col(c)==1) );
            parse(parser,varargin{:});
            obj.Parent = parser.Results.Parent;
            obj.CData  = parser.Results.CData;
            addlistener(obj,'CData','PostSet',@(varargin) obj.update());
        end
        
        function delete(obj)
            obj.Parent = [];
        end
    end
    
    methods( Abstract )
        update(obj)
    end
end