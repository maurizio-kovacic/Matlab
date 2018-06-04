function [ fig ] = display_mesh( P, N, T, C, primitiveMode, M, varargin )
if( nargin < 6 )
    M = Material();
end
if( nargin < 5 )
    primitiveMode = 'face'; % point/vertex, wireframe, wired, face
end
primitiveMode = lower(primitiveMode);

if( nargin < 4 )
    C = [];
end

if( ~isempty(C) )
    M.Alpha                    = 1;
    M.SpecularStrength         = 0;
    M.SpecularColorReflectance = 0;
    M.SpecularExponent         = 1;
end

fig = patch( 'Faces',T,'Vertices',P,...
             'EdgeColor', 'none',...
             'VertexNormals', N,...
             'FaceLighting', 'gouraud', ...
             'FaceColor',                 M.Color,...
             'FaceAlpha',                 M.Alpha,...
             'AmbientStrength',           M.AmbientStrength,...
             'DiffuseStrength',           M.DiffuseStrength,...
             'SpecularStrength',          M.SpecularStrength,...
             'SpecularColorReflectance',  M.SpecularColorReflectance,...
             'SpecularExponent',          M.SpecularExponent,...
             'BackFaceLighting', 'lit' );

if( ~isempty(C) )
    if( issparse(C) )
        C = full(C);
    end
    if( islogical(C) )
        C= double(C);
    end
    C(isinf(C)) = NaN;
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

if( strcmp( primitiveMode, 'vertex' ) || strcmp( primitiveMode, 'point' ) )
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

if( strcmp( primitiveMode, 'wireframe' ) )
    fig.FaceColor = 'none';
    if( ~isempty(C) && ( size(C,1) == 1 ) )
        fig.EdgeColor = C;
    else
        fig.EdgeColor = [0 0 0];
    end
end

if( strcmp( primitiveMode, 'wired' ) )
    fig.EdgeColor = [0 0 0];
end

if( strcmp( primitiveMode, 'face' ) )
    fig.EdgeColor = 'none';
end

end