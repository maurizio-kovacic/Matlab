function [ l ] = mean_edge_length(P,T)
I = T(:,1);
J = T(:,2);
K = T(:,3);
E = [I J; J K; K I];
E = unique(sort(E,2),'rows');
E = vecnorm3(P(E(:,1),:)-P(E(:,2),:));
l = mean(E);    
end