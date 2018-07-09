function [C] = hex2rgb(H)
C = zeros(row(H),3);
if( ischar(H) || isstring(H) )
    H = cell2mat(erase(cellstr(H),'#'));
    C = [base2dec(H(:,1:2),16),...
    	 base2dec(H(:,3:4),16),...
    	 base2dec(H(:,5:6),16)]/255;
end
end