function [CData] = WhiteChrome(CosineData)
CData = [1 1 1] .* chrome_effect(CosineData);
end