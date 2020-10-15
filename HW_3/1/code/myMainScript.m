%% MyMainScript

tic;
%% Your code here

in_image = load('boat'); in_image = in_image.imageOrig;
cor_image = myHarrisCornerDetector(in_image, 0.5, 3, 0.04);

toc;
