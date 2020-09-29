%% MyMainScript

tic;
%% Your code here

img1 = load('../data/barbara.mat');
img1 = img1.imageOrig/255;

img2=imread('../data/grass.png');
img2=single(img2)/255;

img3=imread('../data/honeyCombReal.png');
img3=single(img3)/255;

[out1, RMSD1]=myBilateralFiltering(img1, 0.5, 0.1);

[out2, RMSD2]=myBilateralFiltering(img2, 1.428, 0.1);

[out3, RMSD3]=myBilateralFiltering(img3, 0.75, 0.2);

toc;
