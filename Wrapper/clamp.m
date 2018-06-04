function [V] = clamp(A,min,max)
V = A;
V(V<min)=min;
V(V>max)=max;
end