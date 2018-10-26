function [CData] = silhouette_effect(CRes)
persistent F;
if(isempty(F))
    n = 10;
    d = [0 0 0];
    d = [d 0 fliplr(d)];
    d = [ones(1,n+floor(numel(d)/2)) d ones(1,n+floor(numel(d)/2))]';
    F = griddedInterpolant(linspace(-1,1,numel(d)),d);
end
t = linspace(-1,1,CRes)';
CData = F(t);
end