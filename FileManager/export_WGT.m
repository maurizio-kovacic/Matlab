function export_WGT( filename, W )
formatW = '%u %u %f\n';
[I,J,V] = find(W);
fileID = fopen(strcat(filename,'.wgt'),'wt');
fprintf( fileID, formatW, [I,J,V]' );
fclose(fileID);
end