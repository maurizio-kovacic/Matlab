function [tf] = istetmesh(obj)
    tf = obj.isvolumetric() & ( size(obj.V,2) == 4 );
end