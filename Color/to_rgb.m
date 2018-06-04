function [ RGB ] = to_rgb( V, n_color, range )
if( nargin < 3 )
range = [min(V) max(V)];
end
if( nargin < 2 )
    n_color = 64;
end

m = range(1);
M = range(2);
if( m == M )
    C = zeros(size(V));
else
    C = floor(n_color * (V - m) / (M - m)) / n_color;
end
RGB = hsv2rgb(to_hsv(C));
end