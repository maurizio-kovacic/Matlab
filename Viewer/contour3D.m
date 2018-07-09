function [h] = contour3D(P,T,F,varargin)
F = normalize(F);

A = [];
B = [];
I = [];
n = 10;
for i = 1 : n-1
    C = meandering_triangle(T,F,i/n);
    if(~isempty(C))
        C = C{1};
        A = [A;C.A];
        B = [B;C.B];
        I = [I;C.T];
    end
end
A = from_barycentric(P,T,I,A);
B = from_barycentric(P,T,I,B);
h = line3([A B],'Color','k',varargin{:});

end