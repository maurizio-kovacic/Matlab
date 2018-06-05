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
    an     = acos(dot(repmat([0 0 1],size(T,1),1),T,2));
    F      = repmat({eye(3)},size(P,1),1);
    R      = F;
    i      = find(an>0);
    if( ~isempty(i) )
        R(i) = squeeze(num2cell(axang2rotm([normr(cross(repmat([0 0 1],numel(i),1),T(i,:),2)) an(i,:)]),[1 2]));
        F    = R.*F;
    end
    F      = cell2mat(cellfun(@(M) M(1:9),F,'UniformOutput',false));
    T      = F(:,1:3);
    B      = F(:,4:6);
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