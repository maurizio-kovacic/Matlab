function [HSV] = to_hsv(value)
HSV = cat(2,0.666 - value*0.666,ones(size(value,1),1),ones(size(value,1),1));
end