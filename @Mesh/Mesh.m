classdef Mesh < handle
    properties
        P  % points Nx3
        N  % point normals Nx3
        UV % uv-mappings Nx2
        
        S  % polygons SxM
        V  % volumes  VXM
        
        ExternalVertex % boolean
        ExternalFace   % boolean
        ExternalVolume % boolean
        
        MaterialExternal % material
        MaterialInternal % material
        
        Name % string
    end
    
    methods
        function obj = Mesh(varargin)
            obj.P  = [];
            obj.N  = [];
            obj.UV = [];
            obj.S  = [];
            obj.V  = [];
            obj.MaterialExternal = Material();
            obj.MaterialInternal = Material();
            if( nargin >= 1 )
                obj.P = varargin{1};
            end
            if( nargin >= 2 )
                obj.N = varargin{2};
            end
            if( nargin >= 3 )
                obj.UV = varargin{3};
            end
            if( nargin >= 4 )
                obj.S = varargin{4};
            end
            if( nargin >= 5 )
                obj.V = varargin{5};
            end
            obj = obj.compute_external();
            if( nargin >= 6 )
                obj.MaterialExternal = varargin{6};
            end
            if( nargin >= 7 )
                obj.MaterialInternal = varargin{7};
            end
        end
        
        [tf]  = istrimesh(obj)
        [tf]  = isquadmesh(obj)
        [tf]  = ispolygonmesh(obj)
        [tf]  = isvolumetric(obj)
        [tf]  = istetmesh(obj)
        [tf]  = ishexmesh(obj)
        [tf]  = ispolyhedramesh(obj)
        [tf]  = hasmaterial(obj)
        [obj] = compute_external(obj)
        [obj] = from_OBJ(obj,filename)
        [obj] = from_GEO(obj,filename)
        
    end
    
    methods( Access=private, Hidden=true)
        function [obj] = compute_external_vertex(obj)
            obj.ExternalVertex = false(size(obj.P,1),1);
            if( ~obj.isvolumetric() )
                obj.ExternalVertex = true(size(obj.P,1),1);
                return;
            end
            I = [1:size(obj.S,1)]';
            if( obj.istrimesh() )
                I = repmat(I,3,1);
                J = [obj.S(:,1);obj.S(:,2);obj.S(:,3)];
            end
            if( obj.isquadmesh() )
                I = repmat(I,4,1);
                J = [obj.S(:,1);obj.S(:,2);obj.S(:,3);obj.S(:,4)];
            end
            % TODO polygon
            obj.ExternalVertex = accumarray( J, obj.ExternalFace(I) ) >= 1;
            if( size(obj.ExternalVertex,1) == 1 )
                obj.ExternalVertex = obj.ExternalVertex';
            end
        end
        
        function [obj] = compute_external_face(obj)
            obj.ExternalFace = false(size(obj.S,1),1);
            if( ~obj.isvolumetric() )
                obj.ExternalFace = true(size(obj.S,1),1);
                return;
            end
            if( obj.istetmesh() )
                J = [obj.V(:,1);obj.V(:,2);obj.V(:,3);obj.V(:,4)];
            end
            if( obj.ishexmesh() )
                J = [obj.V(:,1);obj.V(:,2);obj.V(:,3);obj.V(:,4);obj.V(:,5);obj.V(:,6)];
            end
            % TODO polyhedral
            obj.ExternalFace = accumarray(J,1) == 1;
            if( size(obj.ExternalFace,1)==1 )
                obj.ExternalFace = obj.ExternalFace';
            end
        end
        
        function [obj] = compute_external_volume(obj)
            obj.ExternalVolume = false(size(obj.V,1),1);
            if( ~obj.isvolumetric() )
                return;
            end
            I = [1:size(obj.V,1)]';
            if( obj.istetmesh() )
                I = repmat(I,4,1);
                J = [obj.V(:,1);obj.V(:,2);obj.V(:,3);obj.V(:,4)];
            end
            if( obj.ishexmesh() )
                I = repmat(I,6,1);
                J = [obj.V(:,1);obj.V(:,2);obj.V(:,3);obj.V(:,4);obj.V(:,5);obj.V(:,6)];
            end
            % TODO polyhedral
            obj.ExternalVolume = accumarray( I, obj.ExternalFace(J) ) >= 1;
            if( size(obj.ExternalVolume,1) == 1 )
                obj.ExternalVolume = obj.ExternalVolume';
            end
        end
    end
end