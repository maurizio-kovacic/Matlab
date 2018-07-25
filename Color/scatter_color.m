function [C] = scatter_color( NColors, ID, Saturation, Value )
if( nargin < 4 )
    Value = 0.85;
end
if( nargin < 3 )
    Saturation = 0.5;
end
Saturation = repmat(Saturation,numel(ID),1);
Value      = repmat(Value,numel(ID),1);

NColors = NColors+1;

M = repmat(NColors,numel(ID),1);
R = repmat(NColors,numel(ID),1);
B = zeros(numel(ID),1);

k = 2.^(0:32)';
k = k(k<NColors);
for n = 1 : numel(k)
    i = find(bsxfun(@(a,b) a>=b,bitshift(ID,1),M));
    if( ~isempty(i) )
        R(B(i)==0) = k(n);
        B(i) = B(i)+k(n);
        ID(i) = ID(i) - bitshift(M(i)+1,-1);
        M(i) = bitshift(M(i),-1);
    end
    j = setdiff((1:row(ID))',i);
    if( ~isempty(j) )
        M(j) = bitshift(M(j)+1,-1);
    end
    
    i = find(R>(NColors-B));
    if( ~isempty(i) )
        R(i) = NColors-B(i);
    end
end
C = hsv2rgb([B/NColors, Saturation, Value]);
end