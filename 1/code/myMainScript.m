%% MyMainScript

myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ]; 

%% Shrinking image
tic;
im_1=imread('../data/circles_concentric.png');

small_img_D2 = myShrinkImageByFactorD(im_1, 2);
small_img_D3 = myShrinkImageByFactorD(im_1, 3);

figure('Name','Shrinking Image','NumberTitle','off')
subplot(1,3,1), imagesc(im_1);title('Original');colormap (myColorScale); daspect([1 1 1]); colorbar;
subplot(1,3,2), imagesc(small_img_D2); title('D=2'); colormap (myColorScale); daspect([1 1 1]); colorbar;
subplot(1,3,3), imagesc(small_img_D3); title('D=3'); colormap (myColorScale); daspect([1 1 1]); colorbar ;

toc;

%% Enlarging

im=imread('../data/barbaraSmall.png');

bilinear0=myBilinearInterpolation(im);
part_bilinear=bilinear0(1:120, 120:end);

Nearest0=myNearestNeighborInterpolation(im);
part_nearest = Nearest0(1:120, 120:end);

bicubic0=myBicubicInterpolation(im);
part_bicubic=bicubic0(1:120, 120:end);

figure('Name','Comparison','NumberTitle','off')
subplot(1,3,1), imagesc(part_bilinear); title('Bilinear');
daspect([1 1 1]); colorbar;
subplot(1,3,2), imagesc(part_nearest); title('Nearest Neighbour');
daspect([1 1 1]); colorbar;
subplot(1,3,3), imagesc(part_bicubic); title('Bicubic');
daspect([1 1 1]); colorbar;

colormap jet;  
daspect([1 1 1]);

%%

myImageRotation(im);
