function [J] = shuffle_regions_ID(I)
n = max(I);
if( min(I) == 0 )
    n=n+1;
end
p = randperm(n)';
J = p(I);
end