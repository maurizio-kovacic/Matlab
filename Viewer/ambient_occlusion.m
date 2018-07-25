function [A,V] = ambient_occlusion(P,T,sigma)
if( nargin < 4 )
    sigma = 2*mean_edge_length(P,T);
end

X = triangle_barycenter(P,T);
N = triangle_normal(P,T);
[I,J,K] = tri2ind(T);

D = uniform_sphere_sampling(4);

A = zeros(row(T),1);
V = zeros(size(X));

parfor t = 1 : row(T)
    Xt = X(t,:);
    Nt = N(t,:);
    
    d  = vecnorm3(X-Xt);
    i  = find(d<sigma);
    j  = find(dot(repmat(Nt,row(D),1),D,2)>0);
    n  = [];
    for k = 1 : numel(j)
        if( isempty(find(ray_triangle_intersection(Xt,D(j(k),:),P(I(i),:),P(J(i),:),P(K(i),:)),1)) )
            n = [n;j(k)];
        end
    end
    A(t)   = numel(n)/numel(j);
    V(t,:) = normr(mean(D(n,:)));
end

A = face2vertex(A,T);
V = normr(face2vertex(V,T));
end