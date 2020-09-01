%%MymainScript

tic;

% Your code here 

myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

img = imread('../data/test.jpg');
he_img = myHE(img);
myBiHistogramEqualization1=myBiHistogramEqualization(img);
figure, image(img),  title('Test Image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(he_img),  title('Histogram Eqalized image'),colormap(myColorScale), colorbar, daspect([1 1 1]);
figure, image(myBiHistogramEqualization1),  title('Bi-Histogram equalized image'),colormap(myColorScale), colorbar, daspect([1 1 1]);

toc;
