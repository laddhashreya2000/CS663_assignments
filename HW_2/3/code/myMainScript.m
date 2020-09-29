%% MyMainScript
tic;
%% Patch-Based Filtering for barbara.mat
tic;
myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

img = load("../data/barbara.mat");
img = double(img.imageOrig)/100;
% rescaling image
img = imgaussfilt(img,0.66);
img= img(1:2:end,1:2:end);
    
[filtered, corrupted] = myPatchBasedFiltering(img, 25,9,0.15);
disp(getRMSD(filtered, img)); 
figure, imshow(img),  title('Shrinked Original Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imshow(corrupted),  title('Corrupted Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imshow(filtered),  title('Filtered Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
toc;

%% Patch-Based Filtering for grass.png
tic;
img = imread("../data/grass.png");
img = double(img)/double(max(max(img)));
%no rescaling is required
[filtered, corrupted] = myPatchBasedFiltering(img, 25,9,0.1545);
disp(getRMSD(filtered, img));
figure, imshow(img),  title('Original Image Grass.png'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imshow(corrupted),  title('Corrupted Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imshow(filtered),  title('Filtered Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
toc;

%% Patch-Based Filtering for honeyCombReal.png
tic;
img = imread("../data/honeyCombReal.png");
img = double(img)/double(max(max(img)));
%no rescaling done
[filtered, corrupted] = myPatchBasedFiltering(img, 25,9,0.13);
disp(getRMSD(filtered, img));
figure, imshow(img),  title('Original Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imshow(corrupted),  title('Corrupted Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imshow(filtered),  title('Filtered Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
toc;

%% Show mask used to make patches isotropic 

patch_size = 9;
p = floor((patch_size - 1)/2);
sigma = 1.5;
[x,y] = meshgrid(-p:p, -p:p);
gaussian = exp(-(x.^2 + y.^2)/(2*sigma^2));
figure; imshow(gaussian);

toc;