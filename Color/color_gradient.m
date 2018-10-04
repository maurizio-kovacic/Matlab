function [C] = color_gradient(CData,CRes,varargin)
CParam = linspace(0,1,row(CData))';
CRes   = linspace(0,1,CRes)';
C      = interp1(CParam,CData,CRes,varargin{:});
end