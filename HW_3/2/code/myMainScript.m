%% MyMainScript
tic;
%% Your code here
close all;

in1=imread("../data/baboonColor.png");

hs=13;
hr=70;
knn=800;
num_iter=20;
out1=myMeanShiftSegmentation(in1, num_iter, hs, hr, knn);
out1=uint8(out1);
figure; subplot(1,2,1); imagesc(in1); daspect([1 1 1]); axis tight; title('Original');

subplot(1,2,2); imagesc(out1);daspect([1 1 1]); axis tight; title('Segmented');

grayImage = rgb2gray(out1);
[unique_vals, ~, idx] = unique(grayImage(:));
[num, e]=size(unique_vals);
fprintf("Number of unique intensities for Baboon: %d\n", num)

%%

in2=imread("../data/bird.jpg");
in2=imresize(in2, 0.5);
hs=15;
hr=20;
knn=1000;
num_iter=20;
out2=myMeanShiftSegmentation(in2, num_iter, hs, hr, knn);
out2=uint8(out2);
figure; subplot(1,2,1); imagesc(in2); daspect([1 1 1]); axis tight; title('Original');

subplot(1,2,2); imagesc(out2);daspect([1 1 1]); axis tight; title('Segmented');

grayImage = rgb2gray(out2);
[unique_vals, ~, idx] = unique(grayImage(:));
[num, e]=size(unique_vals);
fprintf("Number of unique intensities for bird: %d\n", num)
%%

in3=imread("../data/flower.jpg");

hs=15;
hr=40;
knn=1000;
num_iter=20;
out3=myMeanShiftSegmentation(in3, num_iter, hs, hr, knn);
out3=uint8(out3);
figure; subplot(1,2,1); imagesc(in3); daspect([1 1 1]); axis tight; title('Original');

subplot(1,2,2); imagesc(out3);daspect([1 1 1]); axis tight; title('Segmented');

grayImage = rgb2gray(out3);
[unique_vals, ~, idx] = unique(grayImage(:));
[num, e]=size(unique_vals);
fprintf("Number of unique intensities for Flower: %d\n", num)