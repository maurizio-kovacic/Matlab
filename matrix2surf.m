function [h] = matrix2surf( M )
[X, Y] = meshgrid(linspace(1,size(M,1),size(M,1)),linspace(1,size(M,2),size(M,2)));
h = surf( X, Y, M, 'EdgeColor', 'none', 'FaceColor', 'interp' ); 
% hold on;
% contour3( X, Y, M, linspace( min(min(M)), max(max(M)), 11 ), 'LineColor', 'k' );
end