function [C] = weight2color(W)
C = W * scatter_color(col(W),1:col(W));
end