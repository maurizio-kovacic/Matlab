function tf = isfigure(h)
   tf = strcmp(get(h, 'type'), 'figure');
end