clc;
tic;
close all;
clear;
format long;
I = zeros(300);
I(50:100,50:120)=255;
figure; imshow(I); title("Image I"); colorbar; colormap gray; axis on;
J= zeros(300);
J(120:170,20:90) = 255;
figure; imshow(J); title("Image J"); colorbar; colormap gray; axis on;

%% Without noise

[logf, inverse, row, col] = FFT(I, J);
figure; imshow(logf);colorbar; colormap jet; title("Logarithm of the Fourier magnitude of the cross-power spectrum"); axis on;
figure; imagesc(inverse); colorbar; colormap gray; title("Inverse Fourier transform of cross power spectrum"); axis on;
fprintf("The row index is %d. ", row);
fprintf("The column index is %d.", col);
disp(" ");
    
%% With noise
I = I + rand(size(I)) * 20;
J = J + rand(size(J)) * 20;
figure; imagesc(I); title("Image I with noise"); colorbar; colormap gray; axis on;
figure; imagesc(J); title("Image J with noise"); colorbar; colormap gray; axis on;
[logf, inverse, row, col] = FFT(I, J);
figure; imshow(logf);colorbar; colormap jet; title("Logarithm of the Fourier magnitude of the cross-power spectrum with noise"); axis on;
figure; imagesc(inverse); colorbar; colormap gray; title("Inverse Fourier transform of cross power spectrum with noise"); axis on;
fprintf("The row index is %d. ", row);
fprintf("The column index is %d.", col);
disp(" ");
toc;