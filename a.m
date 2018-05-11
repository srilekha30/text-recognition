[filename, pathname] = uigetfile('*','Select an Image');
imagen=imread(fullfile(pathname, filename));
% Show image
imshow(imagen);
title('INPUT');
figure();
% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
imshow(imagen);
title('GRayscale');
figure();

% Convert to BW
threshold = graythresh(imagen)+0.2;
disp(threshold);
imshow(im2bw(imagen,threshold));
title('Without Negation');
figure();
imagen =~im2bw(imagen,threshold);
imshow(imagen);
figure();
imagen = bwareaopen(imagen,1);
imshow(imagen);