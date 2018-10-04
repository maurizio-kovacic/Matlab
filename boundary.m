function [E] = boundary(T)
[I,J,K] = tri2ind(T);
n  = repmat((1:row(T))',3,1);
E  = [I J; J K; K I];
EE = sort(E,2);
[EE,j,e] = unique(EE,'stable','rows');
A = sparse(e,n,1);
i = find(sum(A,2)==1);
E = E(j(i),:);
end