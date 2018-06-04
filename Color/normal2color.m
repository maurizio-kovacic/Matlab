function [C] = normal2color(N);
C = normr(N);
C = (C + 1).*0.5;
end