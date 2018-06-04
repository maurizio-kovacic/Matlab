function [h] = display_border(P,T,ID,varargin)
if( size(ID,2) == 1 )
    I = T(:,1);
    J = T(:,2);
    K = T(:,3);

    tf = false(size(P,1),1);
    tf(ID) = true;

    E = [I J; J K; K I];
    E = unique(sort(E,2),'rows');
    i = find(tf(E(:,1))&tf(E(:,2)));
    line3( [P(E(i,1),:) P(E(i,2),:)], varargin{1:end} );
else
    line3( [P(ID(:,1),:) P(ID(:,2),:)], varargin{1:end} );
end

end