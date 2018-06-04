function matrix2file(filename,M)
format = [repmat('%f ',1,size(M,2))];
fileID = fopen(strcat(filename,'.txt'),'w');
fprintf( fileID, format, M' );
fclose(fileID);
end