function [C] = color2double(C)
if(~isdouble(C))
    C = double(C)/255;
end
end