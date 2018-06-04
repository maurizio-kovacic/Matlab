function [tf] = ispolyhedramesh(obj)
    tf = obj.isvolumetric() & iscell(obj.V);
end