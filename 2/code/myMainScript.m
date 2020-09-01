%% MyMainScript

tic;
%% Your code here

myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

%% Reading images
img1 = imread('../data/barbara.png');
img2 = imread('../data/TEM.png');
img3 = imread('../data/canyon.png');
img4 = imread('../data/retina.png');
img5 = imread('../data/church.png');
img6 = imread('../data/chestXray.png');
img7 = imread('../data/statue.png');

%% Foreground mask

fm=myForegroundMask(img7);

%% myLinearContrastStretching

tic;
myLinearContrastStretching1 = myLinearContrastStretching(img1);
figure, image(img1),  title('Image 1'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching1), title('Linear Contrast Stretching on Image 1'), colormap(myColorScale), colorbar, daspect([1 1 1]);

myLinearContrastStretching2 = myLinearContrastStretching(img2);
figure, image(img2),  title('Image 2'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching2),  title('Linear Contrast Stretching on Image 2'),colormap(myColorScale), colorbar, daspect([1 1 1]);

myLinearContrastStretching3 = myLinearContrastStretching(img3);
figure, image(img3),  title('Image 3'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching3),  title('Linear Contrast Stretching on Image 3'),colormap(myColorScale), colorbar, daspect([1 1 1]);

myLinearContrastStretching3 = myLinearContrastStretching(img4);
figure, image(img4),  title('Image 4'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching3),  title('Linear Contrast Stretching on Image 4'),colormap(myColorScale), colorbar, daspect([1 1 1]);

myLinearContrastStretching3 = myLinearContrastStretching(img5);
figure, image(img5),  title('Image 5'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching3),  title('Linear Contrast Stretching on Image 5'),colormap(myColorScale), colorbar, daspect([1 1 1]);

myLinearContrastStretching3 = myLinearContrastStretching(img6);
figure, image(img6),  title('Image 6'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching3),  title('Linear Contrast Stretching on Image 6'),colormap(myColorScale), colorbar, daspect([1 1 1]);

myLinearContrastStretching3 = myLinearContrastStretching(fm);
figure, image(img7),  title('Image 7'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myLinearContrastStretching3),  title('Linear Contrast Stretching on Image 7'),colormap(myColorScale), colorbar, daspect([1 1 1]);

toc;

%% myHE
tic;
myHE1 = myHE(img1);
figure, image(img1),  title('Image 1'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imagesc(myHE1), title('Histogram Equalisation 1'), colormap(myColorScale), colorbar, daspect([1 1 1]);

myHE2 = myHE(img2);
figure, image(img2),  title('Image 2'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imagesc(myHE2), title('Histogram Equalisation 2'), colormap(myColorScale), colorbar, daspect([1 1 1]);

myHE3 = myHE(img3);
figure, image(img3),  title('Image 3'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, imagesc(myHE3), title('Histogram Equalisation 3'), colormap(myColorScale), colorbar, daspect([1 1 1]);
toc;

%% myHM

ret1=imread('../data/retina.png');
ret_ref=imread('../data/retinaRef.png');

hm=myHM(ret1, ret_ref);
