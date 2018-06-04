function [tf] = isquadmesh(obj)
    tf = (~iscell(obj.S) &&  size(obj.S,2) == 4 ); 
end