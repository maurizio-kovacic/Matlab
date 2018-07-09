function [h] = connect_figures( h )
ax = get(h,'CurrentAxes');
h = connect_axes([ax{1:end}]);
end