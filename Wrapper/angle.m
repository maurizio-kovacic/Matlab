function [theta] = angle(A,B)
theta = acos(clamp(dotN(A,B),-1,1));
end