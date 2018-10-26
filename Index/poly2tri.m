function [T] = poly2tri(P)
T = [];
for i = 2 : col(P)-1
    T = [T;P(:,1) P(:,i) P(:,mod(i,col(P))+1)];
end
end