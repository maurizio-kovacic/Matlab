function [P,N,UV,T] = import_OFF( filename )
formatH = '%s\n';
formatS = '%u %u %u\n';
formatP = '%f %f %f\n';
formatT = '3 %u %u %u\n';
% formatE = '%u %u\n';

P  = [];
N  = [];
UV = [];
T  = [];

fileID = fopen(strcat(filename,'.off'),'r');
H = textscan( fileID, formatH );
if( strcmp(H{1},'OFF') )
    S = fscanf( fileID, formatS,  [3 1] )';
    P = fscanf( fileID, formatP,  [3 S(1)] )';
    T = fscanf( fileID, formatT,  [3 S(2)] )';
    T = T + ones(size(T));
    N = vertex_normal(P,T);
    UV = zeros(S(1),2);
%     E = fscanf( fileID, formatE, [2 S(3)] )';
end
fclose(fileID);
end