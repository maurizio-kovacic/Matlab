function [CData] = curvature_effect(P,T,baseColor,paletteName)
if((nargin<4)||isempty(paletteName))
    paletteName = 'dusk';
end
if((nargin<3)||isempty(baseColor))
    baseColor = [0.3 0.3 0.3];
end
L = combinatorial_Laplacian(P,T);
F = normalize(clamp(gaussian_curvature(P,T),-0.1,0.1));
F = (speye(row(P),row(P))+0.2*L)\F;
t = 0.5;
CData = (1-t) .* repmat(baseColor,row(P),1) +...
           t  .* fetch_color(color_palette(paletteName),F);
CData = (speye(row(P),row(P))+0.2*L)\CData;
end