function plot_color_palette()
PData = color_palette();
R = zeros(32*row(PData),256);
G = zeros(32*row(PData),256);
B = zeros(32*row(PData),256);
for i = 1 : row(PData)
    C = color_gradient(cell2mat(PData(i,2)),256);
    R((32*(i-1)+1):(32*(i-1)+32),:) = repmat(C(:,1)',32,1);
    G((32*(i-1)+1):(32*(i-1)+32),:) = repmat(C(:,2)',32,1);
    B((32*(i-1)+1):(32*(i-1)+32),:) = repmat(C(:,3)',32,1);
end
I = cat(3,R,G,B);
I = insertText(I,[repmat(96,row(PData),1) (1:32:row(I))'],PData(:,1),'FontSize',18,'BoxOpacity',0);
figure;
imshow(I);
end