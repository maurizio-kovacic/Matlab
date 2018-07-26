function [U] = uniform_sphere_sampling(n)
[u,v,w] = meshgrid(linspace(-1,1,n),linspace(-1,1,n),linspace(-1,1,n));
U = normr([reshape(u,numel(u),1) reshape(v,numel(v),1) reshape(w,numel(w),1)]);
end