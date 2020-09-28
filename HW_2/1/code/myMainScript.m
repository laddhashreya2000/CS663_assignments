%% MyMainScript

tic;
%% Your code here

img1 = load('../data/superMoonCrop.mat');
img2 = load('../data/lionCrop.mat');
img1 = img1.imageOrig;
img2 = img2.imageOrig;

out1=myUnsharpMasking(img1, 1.5, 5);
out2=myUnsharpMasking(img2, 1 , 3);

toc;
