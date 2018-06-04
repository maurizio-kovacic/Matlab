function [varargout] = import_SKEL( filename )
formatN = 'n %s';
formatP = 'p %i\n';
formatC = 'c %u %u\n';
formatK = 'k %u\n';
formatV = 'v %f %f %f\n';
formatD = 'd %f %f %f\n';
formatL = 'l %f %f %f %f %f %f %f %f %f %f %f %f\n';
formatM = 'l %f %f %f %f %f %f %f %f %f %f %f %f\n';
fileID = fopen(strcat(filename,'.skel'),'r');
if( nargout >= 1 )
    tmp = textscan( fileID, formatN );
    varargout{1} = tmp{1};
end
if( nargout >= 2 )
    varargout{2} = fscanf( fileID, formatP, [1 Inf] )' + 1;
end
if( nargout >= 3 )
    T = fscanf( fileID, formatC, [2 Inf] )' + 1;
    varargout{3} = sparse(T(:,1),T(:,2),1,size(varargout{2},1),size(varargout{2},1));
end
if( nargout >= 4 )
    varargout{4} = fscanf( fileID, formatK, [1 Inf] )' + 1;
end
if( nargout >= 5 )
    varargout{5} = fscanf( fileID, formatV, [3 Inf] )';
end
if( nargout >= 6 )
    varargout{6} = fscanf( fileID, formatD, [3 Inf] )';
end
if( nargout >= 7 )
    varargout{7} = fscanf( fileID, formatL, [12 Inf] )';
end
if( nargout >= 8 )
    varargout{8} = fscanf( fileID, formatM, [12 Inf] )';
end
fclose(fileID);
end