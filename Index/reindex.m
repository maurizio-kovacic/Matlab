function [ind,I,J] = reindex(ind)
I    = unique(ind);
J    = (1:numel(I))';
i    = zeros(numel(I),1);
i(I) = J;
ind  = i(ind);
end