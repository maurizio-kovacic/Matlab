function [V] = clamp(A,min,max)
V = A;
% [i,~] = find(V<min);
% V(i,:) = repmat(min,numel(i),1);
% [i,~] = find(V>max);
% V(i,:) = repmat(max,numel(i),1);
V(V<min)=min;
V(V>max)=max;
end