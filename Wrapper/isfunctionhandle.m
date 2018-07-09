function [tf] = isfunctionhandle(h)
tf = isa(h,'function_handle');
end