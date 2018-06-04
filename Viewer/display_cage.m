function [ fig ] = display_cage( P, T, varargin )
fig = display_mesh(P,zeros(size(P)),T,[],'wireframe',varargin{1:end});
end