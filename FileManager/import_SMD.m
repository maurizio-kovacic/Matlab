function [] = import_SMD( filename )
fileID = fopen(filename,'r');
if( fileID == -1 )
    fileID = fopen(strcat(filename,'.smd'),'r');
end
if( fileID == -1 )
    fileID = fopen(strcat(filename,'.SMD'),'r');
end
if( fileID == -1 )
    return;
end

fclose(fileID);
end