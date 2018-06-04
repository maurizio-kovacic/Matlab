function [MVC] = mean_value_coordinates(P,T,X,eps)
if( nargin < 4 )
    eps = 0.0001;
end

deter = @(ui,uj,uk) ui(:,1).*uj(:,2).*uk(:,3)+...
                    ui(:,2).*uj(:,3).*uk(:,1)+...
                    ui(:,3).*uj(:,1).*uk(:,2)-...
                    ui(:,3).*uj(:,2).*uk(:,1)-...
                    ui(:,2).*uj(:,1).*uk(:,3)-...
                    ui(:,1).*uj(:,3).*uk(:,2);

f = @(i,n) sparse(1:numel(i),i,1,numel(i),n);

n = size(P,1);
[I,J,K] = tri2ind(T);

MVC = cell(size(X,1),1);
parfor v = 1 : size(X,1)
    x = X(v,:);
    U = P-repmat(x,n,1);
    D = vecnorm3(U);
    j = find(D<eps);
    if( ~isempty(j) )
        j = j(1);
        MVC{v} = f(j,n);
        continue;
    end
    U = U./D;
    
    L     = [vecnorm3(U(J,:)-U(K,:)) ...
             vecnorm3(U(K,:)-U(I,:)) ...
             vecnorm3(U(I,:)-U(J,:))];
    theta = 2*[asin(L(:,1)./2) asin(L(:,2)./2) asin(L(:,3)./2)];
    H     = sum(theta,2)/2;
    t = find( (repmat(pi,size(H,1),1)-H) < eps );
    if( ~isempty(t) )
        t = t(1);
        W = [sin(theta(t,1))*D(J(t))*D(K(t)) ...
             sin(theta(t,2))*D(K(t))*D(I(t)) ...
             sin(theta(t,3))*D(I(t))*D(J(t))];
        MVC{v} = (W(1) * f(I(t),n) + W(2) * f(J(t),n) + W(3) * f(K(t),n)) / sum(W);
        continue;
    end
    C = [(2*sin(H)*sin(H-theta(:,1)))/(sin(theta(:,2))*sin(theta(:,3)))-1 ...
         (2*sin(H)*sin(H-theta(:,2)))/(sin(theta(:,3))*sin(theta(:,1)))-1 ...
         (2*sin(H)*sin(H-theta(:,3)))/(sin(theta(:,1))*sin(theta(:,2)))-1 ];
    S = sign(deter(U(I,:),U(J,:),U(K,:)))*(1-C.^2).^0.5;
    t = find(abs(S,1)<=eps | abs(S,3)<=eps | abs(S,3)<=eps);
    t = setdiff((1:size(P,1))',t);
    W = [(theta(t,1)-C(t,2)*theta(t,3)-C(t,3)*theta(t,2))/(D(I(t))*sin(theta(t,2))*S(t,3)) ...
         (theta(t,2)-C(t,3)*theta(t,1)-C(t,1)*theta(t,3))/(D(J(t))*sin(theta(t,3))*S(t,1)) ...
         (theta(t,3)-C(t,1)*theta(t,2)-C(t,2)*theta(t,1))/(D(K(t))*sin(theta(t,1))*S(t,2)) ];
    MVC{v} = sum((W(:,1) * f(I(t),n) + W(:,2) * f(J(t),n) + W(:,3) * f(K(t),n)),1)/sum(sum(W,2),1);
end

MVC = vertcat(MVC{:});
end