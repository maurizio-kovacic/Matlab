function [P] = poly2poly(P,side)
P = circrepeat(P,side-col(P),2);
end