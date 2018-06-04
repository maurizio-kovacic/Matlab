function [ P, N, UV, T ] = import_OBJ( filename )
fileID = fopen(strcat(filename,'.obj'),'r');
line   = fgetl(fileID);
P  = [];
N  = [];
UV = [];
T  = [];
while(ischar(line))
    token = line(1);
    if( ~strcmp( token, '#' ) )
        token = strsplit(line);
        if( strcmp( token{1}, 'v' ) )
            x = str2double(token{2});
            y = str2double(token{3});
            z = str2double(token{4});
            P = [P; x,y,z];
        end
        if( strcmp( token{1}, 'vt' ) )
            u = str2double(token{2});
            v = str2double(token{3});
            UV = [UV; u,v];
        end
        if( strcmp( token{1}, 'vn' ) )
            x = str2double(token{2});
            y = str2double(token{3});
            z = str2double(token{4});
            N = [N; x,y,z];
        end
        if( strcmp( token{1}, 'f' ) )
            split = @(s) strsplit( s, '/' );
            extract = @(s) s{1};
            convert = @(s) str2double(s);
            i = convert(extract(split(token{2})));
            j = convert(extract(split(token{3})));
            k = convert(extract(split(token{4})));
            T = [T; i,j,k];
        end
    end
    line = fgetl(fileID);
end
fclose(fileID);
end