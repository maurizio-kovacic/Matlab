function [C] = position2color(P,min,max)
C = normalize(clamp3(P,min,max),min,max);
end