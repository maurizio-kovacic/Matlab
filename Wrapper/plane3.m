function [h] = plane3(P,T,B,side,color)
x = @(p) p(:,1);
y = @(p) p(:,2);
z = @(p) p(:,3);
f = @(p,t,b,c) [c(p)+c(t)+c(b) c(p)+c(t)-c(b) c(p)-c(t)-c(b) c(p)-c(t)+c(b)]';
if( nargin < 5 )
    color = [1 0 0 1];
end
if( nargin < 4 )
    side = 10;
end
if( size(color,1) > 1 )
    color=color(1,:);
end
if( numel(color)==1 )
    color = color*ones(1,4);
end
if( numel(color)==3 )
    color = [color 1];
end
if( nargin < 3 )
    B = [];
end
if( isempty(B) )
    F = eye(3);
    R = reshape(RUt(normr(cross([0 0 1],T,2)),dot([0 0 1],T,2)),3,3);
    F = R*F;
    T = F(:,1)';
    B = F(:,2)';

end
T = side * T;
B = side * B;
X = f(P,T,B,x);
Y = f(P,T,B,y);
Z = f(P,T,B,z);
C = repmat(color(:,1:3),size(X,1),1);
h = fill3( X, Y, Z, 1, 'FaceColor', 'flat' );
set(h,'FaceVertexCData',C);
alpha(h,color(4));
% hold on;
% point3(P,10,[0 0 0],'MarkerFaceColor','flat');
% hold on;
% quiv3(P,N,2);
end