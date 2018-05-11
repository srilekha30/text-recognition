[filename, pathname] = uigetfile('*','Select an Image');
image=imread(fullfile(pathname, filename));
regions = detectMSERFeatures(image);
plot(regions,'showPixelList',true,'showEllipses',false);