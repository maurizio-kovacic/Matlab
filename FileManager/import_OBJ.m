function [ P, N, UV, T ] = import_OBJ( filename )
func_c  = @(d) strcmp(d(1),'#');
func_v  = @(d) strcmp(d(1:2),'v ');
func_vn = @(d) strcmp(d(1:3),'vn ');
func_vt = @(d) strcmp(d(1:3),'vt ');
func_f  = @(d) strcmp(d(1:2),'f ');

P  = [];
N  = [];
UV = [];
T  = [];
fileID = fopen(strcat(filename,'.obj'),'r');
data = textscan(fileID,'%s','Delimiter','\n');
data = data{1};

% search comments
data(cellfun(func_c,data)) = [];

% search vertex
i = find( cellfun(func_v,data) );
if( ~isempty(i) )
    txt = strjoin(data(i),'\n');
    P   = sscanf(txt,'v %f %f %f\n',[3 Inf])';
    data(i) = [];
end

% search texture
i = find( cellfun(func_vt,data) );
if( ~isempty(i) )
    txt = strjoin(data(i),'\n');
    UV   = sscanf(txt,'vt %f %f\n',[2 Inf])';
    data(i) = [];
else
    UV = zeros(size(P,1),2);
end

% search faces
i = find( cellfun(func_f,data) );
if( ~isempty(i) )
    txt = strjoin(data(i),'\n');
    T = strsplit(txt,'\n')';
    T = cellfun(@(d) strrep(d,'f ',''),T,'UniformOutput',false);
    T = cellfun(@(d) extract_faces(d),T,'UniformOutput',false);
    T = cell2mat(T);
    data(i) = [];
end

% search normal
i = find( cellfun(func_vn,data) );
if( ~isempty(i) )
    txt = strjoin(data(i),'\n');
    N   = sscanf(txt,'vn %f %f %f\n',[3 Inf])';
    data(i) = [];
else
    if( ~isempty(T) )
        N = vertex_normal(P,T);
    else
        N = zeros(size(P));
    end
end

fclose(fileID);
end


function [T] = extract_faces(txt)
split_space = @(s) strsplit( s, ' ' );
split_slash = @(s) strsplit( s, '/' );
extract = @(s) s{1};
convert = @(s) str2double(s);
token = split_space(txt);
i = convert(extract(split_slash(token{1})));
j = convert(extract(split_slash(token{2})));
k = convert(extract(split_slash(token{3})));
T = [i,j,k];
end

% function [ P, N, UV, T ] = import_OBJ( filename )
% fileID = fopen(strcat(filename,'.obj'),'r');
% line   = fgetl(fileID);
% P  = [];
% N  = [];
% UV = [];
% T  = [];
% while(ischar(line))
%     token = line(1);
%     if( ~strcmp( token, '#' ) )
%         token = strsplit(line);
%         if( strcmp( token{1}, 'v' ) )
%             x = str2double(token{2});
%             y = str2double(token{3});
%             z = str2double(token{4});
%             P = [P; x,y,z];
%         end
%         if( strcmp( token{1}, 'vt' ) )
%             u = str2double(token{2});
%             v = str2double(token{3});
%             UV = [UV; u,v];
%         end
%         if( strcmp( token{1}, 'vn' ) )
%             x = str2double(token{2});
%             y = str2double(token{3});
%             z = str2double(token{4});
%             N = [N; x,y,z];
%         end
%         if( strcmp( token{1}, 'f' ) )
%             split = @(s) strsplit( s, '/' );
%             extract = @(s) s{1};
%             convert = @(s) str2double(s);
%             i = convert(extract(split(token{2})));
%             j = convert(extract(split(token{3})));
%             k = convert(extract(split(token{4})));
%             T = [T; i,j,k];
%         end
%     end
%     line = fgetl(fileID);
% end
% fclose(fileID);
% end