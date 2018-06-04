function [ds] = specular_direction(dn,di)
ds = normr(2.*dot(dn,di,2).*dn-di);
end