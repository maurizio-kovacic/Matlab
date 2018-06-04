function [A,t,L,k] = heat_diffusion_data(P,T,i,varargin)
A = barycentric_area(P,T);
if( isempty(varargin) )
t = diffusion_time(1,mean_edge_length(P,T));
else
t = diffusion_mass(P,T,varargin{1});
end
L = cotangent_Laplacian(P,T);
k = Kronecker_delta(i,size(P,1));
end