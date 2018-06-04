function [x] = linear_problem(A,b)
    x = (A+0.000001*speye(size(A)))\b;
end