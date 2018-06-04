function [u] = laplace_problem(L)
    u = linear_problem(L,zeros(size(L,2),1));
end