%预处理程序2
%手写数字识别
I = imread('nums.jpg');%读取原始图像
subplot(2,2,1);
imshow(I);
title('原始图像');

Igray = rgb2gray(I);%图像灰度化
subplot(2,2,2);
imshow(Igray);
title('灰度图像');
Igray = 255-Igray;%图像反相
% figure
% imhist(Igray,150)
% title('直方图');

% se = strel('disk',8);
% background = imopen(Igray,se);
% figure
% imshow(background);
% title('图像背景')

% Ibw =im2bw(Igray,graythresh(Igray));%图像二值化

Ibw =im2bw(Igray,0.6);
subplot(2,2,3);
% Ibw = ~Ibw;
imshow(Ibw);    
title('二值化图像');

se= strel('disk',4);%腐蚀结构不好选
Ibw_fushi = imerode(Ibw,se);
subplot(2,2,4);
imshow(Ibw_fushi);    
title('腐蚀');
se1= strel('disk',13);
Ibw_pengzhang = imdilate(Ibw_fushi,se1);
figure
imshow(Ibw_pengzhang);    
title('膨胀');

% %字符分割
% Iarea_label = bwlabel(Ibw_pengzhang,8);
% M = max(max(Iarea_label));
% pixelcount1 = zeros(M,1);
% for i = 1:M
%     pixelcount1(i) = numel(find(Iarea_label==i));
% end
% pixelcount1_sort = sort(pixelcount1,'descend');
% pixelcount1(pixelcount1<pixelcount1_sort(2)) = 0;
% numindex = find(pixelcount1~=0);
% for i = 1:2
%     [temprow,tempcol] = find(Iarea_label==numindex(i));
%     exrow.min = min(temprow);
%     exrow.max = max(temprow);
%     excol.min = min(tempcol);
%     excol.max = max(tempcol);
%    
%     result{i} = Iarea_label(exrow.min:exrow.max,excol.min:excol.max);
% end
% figure
% subplot(1,2,1)
% imshow(result{1}>=1);
% t1 = title('');
% subplot(1,2,2);
% imshow(result{2}>=1);
% t2 = title('');
% ------------------------------------------
[L,num] = bwlabel(Ibw_pengzhang);
status=regionprops(Ibw_pengzhang,'area','BoundingBox');
areas = [status.Area ];
[areas_sort,index] = sort(areas,2,'ascend');
rects = cat(1,  status.BoundingBox); 
[~, max_id] = max(areas);  
% [~, max_id] = find([status.Area] > 100);
max_rect = rects(max_id, :);   
%show the largest connected region    
figure
imshow(Ibw_pengzhang);
title('连通区域');
for i = 1:size(rects,1)
    rectangle('position', rects(i,:), 'EdgeColor', 'r');
end
% rectangle('position',max_rect, 'EdgeColor', 'r');

 
% bw_reg = imcrop(Ibw_pengzhang,max_rect);
% figure
% imshow(bw_reg);
% title('连通区域截取');

bw1 = imcrop(Ibw_pengzhang,rects(index(1),:));
bw2 = imcrop(Ibw_pengzhang,rects(index(6),:));
bw3 = imcrop(Ibw_pengzhang,rects(index(3),:));
bw4 = imcrop(Ibw_pengzhang,rects(index(8),:));
bw5 = imcrop(Ibw_pengzhang,rects(index(7),:));
bw6 = imcrop(Ibw_pengzhang,rects(index(5),:));
bw7 = imcrop(Ibw_pengzhang,rects(index(2),:));
bw8 = imcrop(Ibw_pengzhang,rects(index(9),:));
bw9 = imcrop(Ibw_pengzhang,rects(index(4),:));

figure
subplot(3,3,1)
imshow(bw1);
title('1的连通区域截取');
subplot(3,3,2)
imshow(bw2);
title('2的连通区域截取');
subplot(3,3,3)
imshow(bw3);
title('3的连通区域截取');
subplot(3,3,4)
imshow(bw4);
title('4的连通区域截取');
subplot(3,3,5)
imshow(bw5);
title('5的连通区域截取');
subplot(3,3,6)
imshow(bw6);
title('6的连通区域截取');
subplot(3,3,7)
imshow(bw7);
title('7的连通区域截取');
subplot(3,3,8)
imshow(bw8);
title('8的连通区域截取');
subplot(3,3,9)
imshow(bw9);
title('9的连通区域截取');

 bw1_3232 = imresize(bw1,[32,32]);
 bw2_3232 = imresize(bw2,[32,32]);
 bw3_3232 = imresize(bw3,[32,32]);
 bw4_3232 = imresize(bw4,[32,32]);
 bw5_3232 = imresize(bw5,[32,32]);
 bw6_3232 = imresize(bw6,[32,32]);
 bw7_3232 = imresize(bw7,[32,32]);
 bw8_3232 = imresize(bw8,[32,32]);
 bw9_3232 = imresize(bw9,[32,32]);
 figure
subplot(3,3,1)
imshow(bw1_3232);
title('1的归一化图像');
subplot(3,3,2)
imshow(bw2_3232);
title('2的归一化图像');
subplot(3,3,3)
imshow(bw3_3232);
title('3的归一化图像');
subplot(3,3,4)
imshow(bw4_3232);
title('4的归一化图像');
subplot(3,3,5)
imshow(bw5_3232);
title('5的归一化图像');
subplot(3,3,6)
imshow(bw6_3232);
title('6的归一化图像');
subplot(3,3,7)
imshow(bw7_3232);
title('7的归一化图像');
subplot(3,3,8)
imshow(bw8_3232);
title('8的归一化图像');
subplot(3,3,9)
imshow(bw9_3232);
title('9的归一化图像');
dlmwrite('F:\matrialofgra\KNN1\testDigits\1_0.txt',bw1_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\2_0.txt',bw2_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\3_0.txt',bw3_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\4_0.txt',bw4_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\5_0.txt',bw5_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\6_0.txt',bw6_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\7_0.txt',bw7_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\8_0.txt',bw8_3232,'delimiter','','newline','pc');
dlmwrite('F:\matrialofgra\KNN1\testDigits\9_0.txt',bw9_3232,'delimiter','','newline','pc');

% figure
% subplot(1,2,1);
% imshow(bw3_3232);
% subplot(1,2,2);
% imshow(bw8_3232);
% title('归一化图像');
% dlmwrite('F:\matrialofgra\KNN1\testDigits\3_1.txt',bw3_3232,'delimiter','','newline','pc');
% dlmwrite('F:\matrialofgra\KNN1\testDigits\8_1.txt',bw8_3232,'delimiter','','newline','pc');
% csvwrite('0_0.csv',bw_3232);%将二值化图像以矩阵的形式导出
