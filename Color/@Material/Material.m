classdef Material
    properties
        Color                    % [R G B], default [0.5 0.5 0.5]
        Alpha                    % scalar in [0,1], default 1
        AmbientStrength          % scalar in [0,1], default 0.3
        DiffuseStrength          % scalar in [0,1], default 0.6
        SpecularStrength         % scalar in [0,1], default 0.9
        SpecularExponent         % scalar greater than 0, default 10
        SpecularColorReflectance % scalar in [0,1], default 1
    end
    
    methods
        function obj = Material(varargin)
            if( nargin >= 1 )
                obj.Color = varargin{1};
            else
                obj.Color = [0.5 0.5 0.5];
            end
            if( nargin >= 2 )
                obj.Alpha = varargin{2};
            else
                obj.Alpha = 1;
            end
            if( nargin >= 3 )
                obj.AmbientStrength = varargin{3};
            else
                obj.AmbientStrength = 0.3;
            end
            if( nargin >= 4 )
                obj.DiffuseStrength = varargin{4};
            else
                obj.DiffuseStrength = 0.6; 
            end
            if( nargin >= 5 )
                obj.SpecularStrength = varargin{5};
            else
                obj.SpecularStrength = 0.9;
            end
            if( nargin >= 6 )
                obj.SpecularExponent = varargin{6};
            else
                obj.SpecularExponent = 10;
            end
            if( nargin >= 7 )
                obj.SpecularColorReflectance = varargin{7};
            else
                obj.SpecularColorReflectance = 1;
            end
        end
    end
    
    methods(Static)
        function obj = Rubber(Color,Alpha)
            if( nargin < 2 )
                Alpha = 1;
            end
            if( nargin < 1 )
                Color = [0.5 0.5 0.5];
            end
            obj = Material(Color,...
                           Alpha,...
                           0.2,...
                           0.7,...
                           0,...
                           1,...
                           0);
        end
        
        function obj = Gray(varargin)
            obj = Material.Rubber([0.5 0.5 0.5],varargin{1:end});
        end
        
        function obj = Blue(varargin)
            obj = Material.Rubber([0.2 0.3 0.8],varargin{1:end});
        end
        
        function obj = Orange(varargin)
            obj = Material.Rubber([1.0 0.7 0.2],varargin{1:end});
        end
        
        function obj = Gold()
            obj = Material([1 0.8941 0.2275],...
                            1,...
                            0.2,...
                            0.7,...
                            1,...
                            3,...
                            1);
        end
        
        
        
        
    end
end