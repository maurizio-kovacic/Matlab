function [C] = fetch_color(CData,FData)
FData = normalize(FData);
C = interp1(linspace(0,1,row(CData)),CData,FData);
end