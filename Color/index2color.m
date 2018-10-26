function [C] = index2color(ID)
ID = uint32(ID);
C = reshape(typecast(ID,'uint8'),4,row(ID))';
C = [C(:,1) C(:,2) C(:,3)];
end