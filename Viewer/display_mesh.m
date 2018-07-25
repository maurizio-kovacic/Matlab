function [ fig ] = display_mesh( P, N, T, C, primitiveMode, M, varargin )
if( nargin < 6 )
    M = Material([0.5 0.5 0.5],1,0.3,0.6,0.3,100,0.5);
end
if( nargin < 5 )
    primitiveMode = 'face'; % point/vertex, wireframe, wired, face/solid
end
if( isempty(T) )
    primitiveMode = 'vertex';
end
if( isempty(primitiveMode) )
    primitiveMode = 'face';
end

primitiveMode = lower(primitiveMode);

if( nargin < 4 )
    C = [];
end

if( ~isempty(C) && col(C) == 1 )
    M.Alpha                    = 1;
    M.SpecularStrength         = 0;
    M.SpecularColorReflectance = 0;
    M.SpecularExponent         = 1;
end

% if( isempty(C) && col(T)==3 )
%     C = mesh_color(P,T,[0.3 0.3 0.3]);
%     if( find(~isfinite(C),1) )
%         C = [];
%     end
% end

fig = patch( 'Faces',full(T),'Vertices',full(P),'VertexNormals', full(N),...
             'EdgeColor',                 'none',...
             'FaceLighting',              'gouraud', ...
             'FaceColor',                 M.Color,...
             'FaceAlpha',                 M.Alpha,...
             'AmbientStrength',           M.AmbientStrength,...
             'DiffuseStrength',           M.DiffuseStrength,...
             'SpecularStrength',          M.SpecularStrength,...
             'SpecularColorReflectance',  M.SpecularColorReflectance,...
             'SpecularExponent',          M.SpecularExponent,...
             'BackFaceLighting',          'lit',...
             varargin{:} );
    
if( ~isempty(C) )
    if( issparse(C) )
        C = full(C);
    end
    if( islogical(C) )
        C = double(C);
    end
    C(~isfinite(C)) = NaN;
    A = ones(size(C,1),1);
    if( size(C,2) == 4 )
        A = C(:,4);
    end
    if( ( size(C,1) == 1 ) )
        fig.FaceColor = C(1:3);
        fig.FaceAlpha = A;
    else
        if( size(C,2) == 1 )
            fig.FaceVertexCData = C;
        else
            fig.FaceVertexCData = C(:,1:3);
        end
        fig.FaceAlpha = 1;
        if( size(C,1) == size(T,1) )
            fig.FaceColor = 'flat';
            if( size(C,2) > 3 )
                fig.FaceAlpha = 'flat';
                fig.FaceVertexAlphaData = A;
            end
        else
            fig.FaceColor = 'interp';
            if( size(C,2) > 3 )
                fig.FaceAlpha = 'interp';
                fig.FaceVertexAlphaData = A;
            end
        end
    end
end

if( strcmpi( primitiveMode, 'vertex' ) || strcmpi( primitiveMode, 'point' ) )
    fig.FaceColor = 'none';
    fig.EdgeColor = 'none';
    fig.Marker = '.';
    if( ~isempty(C) && ( size(C,1) == 1 ) )
        fig.MarkerEdgeColor = C;
        fig.MarkerFaceColor = C;
    else
        fig.MarkerEdgeColor = [0 0 0];
        fig.MarkerFaceColor = [0 0 0];
    end
    fig.MarkerSize = mesh_scale(P) / 100;
end

if( strcmpi( primitiveMode, 'wireframe' ) )
    fig.FaceColor = 'none';
    if( ~isempty(C) && ( size(C,1) == 1 ) )
        fig.EdgeColor = C;
    else
        fig.EdgeColor = [0 0 0];
    end
end

if( strcmpi( primitiveMode, 'wired' ) )
    fig.EdgeColor = [0 0 0];
end

if( strcmpi( primitiveMode, 'face' ) || strcmpi( primitiveMode, 'solid' ) )
    fig.EdgeColor = 'none';
end

end