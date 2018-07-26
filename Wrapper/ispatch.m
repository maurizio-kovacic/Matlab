function tf = ispatch(h)
   tf = strcmp(get(h, 'type'), 'patch');
end