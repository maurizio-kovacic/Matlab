function [CData] = cartoon_effect(CosineData)
persistent R G B;
if(isempty(R))
    eps = 0.0001;
    x   = [-1 (-0.9-eps) -0.9 (-0.6-eps) -0.6 0 1];
    R = griddedInterpolant(x, [1     1 1 1 0.7 0.7 0.7]');
    G = griddedInterpolant(x, [0.5 0.5 0 0   0   0   0]');
    B = griddedInterpolant(x, [0     0 0 0   0   0   0]');
end
CData = [R(CosineData) G(CosineData) B(CosineData)];
end