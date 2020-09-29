%% MyMainScript

tic;
%% Your code here
close all

img1 = load('../data/barbara.mat');
img1 = img1.imageOrig;

img2=imread('../data/grass.png');
img2=single(img2);

img3=imread('../data/honeyCombReal.png');
img3=single(img3);

[out1, RMSD1]=myBilateralFiltering(img1, 1.5, 0.1);

[out2, RMSD2]=myBilateralFiltering(img2, 1.428, 0.1);

[out3, RMSD3]=myBilateralFiltering(img3, 0.75, 0.2);

toc;
