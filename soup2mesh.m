function [P,N,UV,T,varargout] = soup2mesh(P,N,UV,T,varargin)
n = row(P);
[P,I,J] = uniquetol(P,0.0001,'ByRows',true);
N  = N(I,:);
UV = UV(I,:);
T(:) = J(T);
if( nargin >= nargout )
    if( nargout >= 5 )
        for i = 1 : (nargout-4)
            if( row(varargin{i})==n )
                varargout{i} = varargin{i}(I,:);
            else
                varargout{i} = J(varargin{i});
            end
        end
    end
end
A = triangle_area(P,T);
t = find(A==0);
T(t,:)  = [];
end