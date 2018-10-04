function [ax] = get_axes(h)
ax = h(isaxes(h));
h  = get(h(isfigure(h)),'Children');
ax = [ax;h(isaxes(h))];
end