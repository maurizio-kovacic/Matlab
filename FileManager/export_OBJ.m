function export_OBJ( filename, P, N, UV, F )
formatP = 'v %f %f %f\n';
formatN = 'vn %f %f %f\n';
formatUV = 'vt %f %f\n';
hasN  = false;
hasUV = false;
fileID = fopen(strcat(filename,'.obj'),'wt');
fprintf( fileID, formatP, P' );
if( row(N) > 0 )
    hasN = true;
    fprintf( fileID, formatN, N' );
end
if( row(UV) > 0 )
    hasUV = true;
    fprintf( fileID, formatUV, UV' );
end
if( row(F) > 0 )
    token = cell2mat(strcat(['%u','/'*(hasN|hasUV),'%u'*hasUV,'/%u'*hasN],{' '}));
    formatF = ['f ', repmat(token,1,col(F)), '\n'];
    F = repelem(F(:,1:end),1,1+hasN+hasUV);
    fprintf( fileID, formatF, F' );
end
fclose(fileID);
end