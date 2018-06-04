function export_OBJ( filename, V, N, UV, P )
formatV = 'v %f %f %f\n';
formatN = 'vn %f %f %f\n';
formatUV = 'vt %f %f\n';
hasN  = false;
hasUV = false;
fileID = fopen(strcat(filename,'.obj'),'w');
fprintf( fileID, formatV, V' );
if( size(N,1) > 0 )
    hasN = true;
    fprintf( fileID, formatN, N' );
end
if( size(UV,1) > 0 )
    hasUV = true;
    fprintf( fileID, formatUV, UV' );
end
if( size(P,1) > 0 )
    token = [strrep(['%u','/'*(hasN|hasUV),'%u'*hasUV,'/%u'*hasN], 0, ''), ' '];
    formatF = ['f ', repmat(token,1,size(P,2)), '\n'];
    F = repelem(P(:,1:end),1,1+hasN+hasUV);
    fprintf( fileID, formatF, F' );
end
fclose(fileID);
end