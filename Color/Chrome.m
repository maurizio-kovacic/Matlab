function [CData] = Chrome(CData,CRes)
t     = linspace(-1,1,CRes)';
CData = interp1([-1 -0.98 -0.9 -0.1 1]',[1 1 1;CData],t);
CData = clamp(CData .* chrome_effect(CRes),[0 0 0],[1 1 1]);
end