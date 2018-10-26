function [Output] = accumarrayN(Index,Value,varargin)
Output = cell(1,col(Value));
for i = 1 : col(Value)
    Output{i} = accumarray(Index,Value(:,i),varargin{:});
end
Output = cell2mat(Output);
end