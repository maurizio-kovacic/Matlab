function [T] = linearize_transform(T)
f = @(M,n) cell2mat(cellfun(@(m) m(1:n),M,'UniformOutput',false));
switch numel(T{1})
    case 9
        T = f(T,9);
    otherwise
        T = f(T,12);
end
end
