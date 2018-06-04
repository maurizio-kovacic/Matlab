function [tf] = istrimesh(obj)
    tf = (~iscell(obj.S) && size(obj.S,2) == 3 ); 
end