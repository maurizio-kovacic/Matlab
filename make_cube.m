function [P,N,UV,T] = make_cube(radius)
if( nargin < 1 )
    radius = 1;
end
P  = [ radius  radius  radius;...
      -radius  radius  radius;...
       radius -radius  radius;...
      -radius -radius  radius;...
       radius  radius -radius;...
      -radius  radius -radius;...
       radius -radius -radius;...
      -radius -radius -radius];
N  = normr(P);
UV = zeros(size(P,1),2);
T  = [1 3 2; 3 4 2; ...
      6 8 7; 5 6 7; ...
      1 6 5; 1 2 6; ...
      3 7 4; 8 4 7; ...
      1 7 3; 1 5 7; ...
      2 8 6; 2 4 8];
end