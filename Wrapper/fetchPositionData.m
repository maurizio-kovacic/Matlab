function [PData] = fetchPositionData(PBuffer,PointMin,PointMax,bufferIndex)
[PData] = color2position(...
    color2double(fetchBufferData(PBuffer,bufferIndex)),...
    PointMin,PointMax);
end