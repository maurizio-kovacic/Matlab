function [E] = poly2edge(P)
E = [];
for i = 1 : col(P)
    E = [E;P(:,i) P(:,mod(i,col(P))+1)];
end
end