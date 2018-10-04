function [P] = transform_plane(T,P)
P = (inv(T)'*P')';
end