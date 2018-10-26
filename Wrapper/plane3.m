% function [h] = plane3(P,T,B,side,color,varargin)
% x = @(p) p(:,1);
% y = @(p) p(:,2);
% z = @(p) p(:,3);
% f = @(p,t,b,c) [c(p)+c(t)+c(b) c(p)+c(t)-c(b) c(p)-c(t)-c(b) c(p)-c(t)+c(b)]';
% if( nargin < 5 )
%     color = [1 0 0 1];
% end
% if( nargin < 4 )
%     side = 10;
% end
% if( size(color,1) > 1 )
%     color=color(1,:);
% end
% if( numel(color)==1 )
%     color = color*ones(1,4);
% end
% if( numel(color)==3 )
%     color = [color 1];
% end
% if( nargin < 3 )
%     B = [];
% end
% if( isempty(B) )
%     an     = acos(dot(repmat([0 0 1],size(T,1),1),normr(T),2));
%     F      = repmat({eye(3)},size(P,1),1);
%     R      = F;
%     i      = find(an>0);
%     if( ~isempty(i) )
% %         R(i) = squeeze(num2cell(axang2rotm([normr(cross(repmat([0 0 1],numel(i),1),T(i,:),2)) an(i,:)]),[1 2]));
%         R(i) = squeeze(num2cell(axang2rotm([(cross(repmat([0 0 1],numel(i),1),T(i,:),2)) an(i,:)]),[1 2]));
%         F    = cellfun(@mtimes,R,F,'UniformOutput',false);
%     end
%     F      = cell2mat(cellfun(@(M) M(1:9),F,'UniformOutput',false));
%     T      = F(:,1:3);
%     B      = F(:,4:6);
% end
% T = side * T;
% B = side * B;
% X = f(P,T,B,x);
% Y = f(P,T,B,y);
% Z = f(P,T,B,z);
% C = repmat(color(:,1:3),size(X,1),1);
% h = fill3( X, Y, Z, 1, 'FaceColor', 'flat' );
% end

function [h] = plane3(Position,Orientation,Side,CData,varargin)
if(row(Position)==1)
    Position = repmat(Position,row(Orientation),1);
end
if(row(Orientation)==1)
    Orientation = repmat(Orientation,row(Position),1);
end
Q     = reshape((1:row(Position)*4),4,row(Position))';
PData = repmat(Side .* [-0.5 -0.5 0; 0.5 -0.5 0; 0.5 0.5 0; -0.5 0.5 0],1,1);%row(Position),1);
NData = repmat([0 0 1],1,1);%row(Position),1);
if( col(CData)==4 )
    AData = CData(:,4);
    CData = CData(:,1:3);
else
    AData = 1;
end

PP = [];
NN = [];
for i = 1 : row(Position)
    axis  = cross(NData,Orientation(i,:),2);
    angle = acos(dot(NData,normr(Orientation(i,:)),2));
    if(angle>0)
        R = axang2rotm([axis,angle]);
    else
        R = eye(3);
    end
    P = zeros(4,3);
    N = zeros(4,3);
    for j = 1 : 4
        P(j,:) = (R * PData(j,:)')';
        N(j,:) = (R * [0;0;1])';
    end
    PP = [PP;P];
    NN = [NN;N];
%     PData(i:i+3,:) = P(:,1:3);
%     NData(i:i+3,:) = N(:,1:3);
end
h = patch('Faces',               Q,...
          'Vertices',            PP+Position,...
          'VertexNormals' ,      NN,...
          'FaceColor',           'flat',...
          'FaceVertexCData',     CData,...
          'FaceLighting',        'none',...
          'EdgeColor',           'k',...
          'FaceAlpha',           'flat',...
          'FaceVertexAlphaData', AData,...
          varargin{:});

end