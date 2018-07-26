function [h] = high_res_figure(h)
W = h.Position(3);
H = h.Position(4);
h.PaperPositionMode = 'manual';
h.PaperPosition = [0 0 2*W 2*H];
end