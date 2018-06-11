function export_OFF(filename,P,T)
formatH = '%s\n';
formatS = '%u %u %u\n';
formatP = '%f %f %f\n';
formatT = '';
formatE = '%u %u\n';
T = T - ones(size(T));
if( size(T,2) == 3 )
    [I,J,K] = tri2ind(T);
    E = unique(sort([I J; J K; K I],2),'rows');
    formatT = '3 %u %u %u\n';
end
if( size(T,2) == 4 )
    [I,J,K,L] = quad2ind(T);
    E = unique(sort([I J; J K; K L; L I],2),'rows');
    formatT = '4 %u %u %u %u\n';
end
H = 'OFF';
S = [size(P,1) size(T,1) size(E,1)];

fileID = fopen(strcat(filename,'.off'),'wt');
fprintf( fileID, formatH, H  );
fprintf( fileID, formatS, S' );
fprintf( fileID, formatP, P' );
fprintf( fileID, formatT, T' );
fprintf( fileID, formatE, E' );
fclose(fileID);
end