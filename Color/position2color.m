function [C] = position2color(P,Min,Max)
if( nargin < 3 )
    Max = max(P);
end
if( nargin < 2 )
    Min = min(P);
end
C = normalize(clamp3(P,Min,Max),Min,Max);
end