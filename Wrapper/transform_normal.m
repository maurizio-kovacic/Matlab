function [N] = transform_normal(t,n)
N = [dot(t(:,1: 3),n,2) dot(t(:,4: 6),n,2) dot(t(:,7:9),n,2)];
end