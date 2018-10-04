function [C] = interleave(varargin)
varargin = cellfun(@(v) num2cell(v,2),varargin,'UniformOutput',false);
C = cell2mat(cellfun(@interleave_helper,varargin{:},'UniformOutput',false));
end

function [C] = interleave_helper(varargin)
C = cell2mat(varargin');
end