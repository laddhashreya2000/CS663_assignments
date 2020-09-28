%% MyMainScript

tic;
%% Your code here

img1 = load('../data/barbara.mat');
img1 = img1.imageOrig;

img2=imread('../data/grass.png');

img3=imread('../data/honeyCombReal.png');

[out1, RMSD1]=myBilateralFiltering(img1, 0.5, 0.1);

[out2, RMSD2]=myBilateralFiltering(img2, 1.428, 0.1);

[out3, RMSD3]=myBilateralFiltering(img3, 0.75, 0.2);

toc;
