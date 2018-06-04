function [K] = gaussian_curvature(P,T)
    A = diag(barycentric_area(P,T));
    [I,J,K] = tri2ind(T);
    Pi = P(I,:);
    Pj = P(J,:);
    Pk = P(K,:);
    Eij = normr(Pj - Pi);
    Ejk = normr(Pk - Pj);
    Eki = normr(Pi - Pk);
    theta = accumarray([I;J;K],[acos(dot(Eij,-Eki,2));acos(dot(Ejk,-Eij,2));acos(dot(Eki,-Ejk,2));]);
    K = ( repmat(2*pi,size(P,1),1) - theta ) ./ A;
end