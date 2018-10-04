function [n] = skinning_valence(W)
[i,~] = find(W);
n = accumarray(i,1);
end