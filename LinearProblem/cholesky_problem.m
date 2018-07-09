function [x] = cholesky_problem(Luk,L,Lt,vk,P)
b = -Luk * vk;
y = L \ b;
x = Lt \ y;
x = P' * [x; vk];
end