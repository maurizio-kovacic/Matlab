function [Adj] = n_ring(P,T,n,ID)
if( nargin < 4 )
    ID = [];
end
if( nargin < 3 )
    n = 1;
end
Adj = Adjacency(P,T,'comb');
if( ~isempty(ID) )
    ID = setdiff((1:size(Adj,1))',ID);
    Adj(ID,:) = 0;
    Adj(:,ID) = 0;
end
if( n > 1 )
    Adj = Adj^n;
    Adj(Adj~=0) = 1;
    i = sub2ind(size(Adj),(1:size(Adj,1))',(1:size(Adj,2))');
    Adj(i) = 0;
end
end