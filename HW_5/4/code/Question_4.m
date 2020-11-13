clear all; close all;
im = imread('barbara256.png');
[m,n] = size(im); c1 = m/2; c2 = n/2;
im_ft = fftshift(fft2(im));
im_ft_mag = abs(im_ft);
im_ft_log = log(1+im_ft_mag);
figure();
imshow(mat2gray(im_ft_log)); colormap jet; colorbar; title('Log magnitude of the Fourier transform');

%% Ideal LPF for D1 = 40 and D2 = 80
D1 = 40; D2 = 80;
H_ideal_D1 = zeros(m,n); H_ideal_D2 = zeros(m,n); 
for x = 1:m
    for y = 1:n
        if (x-c1)^2 + (y-c2)^2 <= D1^2
            H_ideal_D1(x,y) = 1;
        end
        if (x-c1)^2 + (y-c2)^2 <= D2^2
            H_ideal_D2(x,y) = 1;
        end        
    end
end
figure();
subplot(1,2,1);
imshow(mat2gray(log(1+ H_ideal_D1))); colormap gray; colorbar; title('Plot of log magnitude of ideal LPF response for D = 40');
subplot(1,2,2);
imshow(mat2gray(log(1+ H_ideal_D2))); colormap gray; colorbar; title('Plot of log magnitude of ideal LPF response for D = 80');
%% Gaussian LPF for sig1 = 40 and sig2 = 80
sig1 = 40; sig2 = 80;
H_gauss_D1 = zeros(m,n); H_gauss_D2 = zeros(m,n); 
for x = 1:m
    for y = 1:n
        H_gauss_D1(x,y) = exp(-((x-c1)^2 + (y-c2)^2)/(2*sig1^2));
        H_gauss_D2(x,y) = exp(-((x-c1)^2 + (y-c2)^2)/(2*sig2^2));        
    end
end
figure();
subplot(1,2,1);
imshow(mat2gray(log(1+ H_gauss_D1))); colormap gray; colorbar; title('Plot of log magnitude of gaussian LPF response(deviation = 40)');
subplot(1,2,2);
imshow(mat2gray(log(1+ H_gauss_D2))); colormap gray; colorbar; title('Plot of log magnitude of gaussian LPF response(deviation = 80)');
%% Output images for ideal filter
ft_ideal_D1 = H_ideal_D1.*im_ft;
ft_ideal_D2 = H_ideal_D2.*im_ft;
im_ideal_D1 = ifft2(ifftshift(ft_ideal_D1)); im_ideal_D1 = abs(im_ideal_D1); 
im_ideal_D2 = ifft2(ifftshift(ft_ideal_D2)); im_ideal_D2 = abs(im_ideal_D2);
figure();
subplot(1,2,1);
imshow(mat2gray(im_ideal_D1)); colormap gray; colorbar; title('Output image for ideal LPF filter with D = 40');
subplot(1,2,2);
imshow(mat2gray(im_ideal_D2)); colormap gray; colorbar; title('Output image for ideal LPF filter with D = 80');

%% Output images for gaussian filter
ft_gau_D1 = H_gauss_D1.*im_ft;
ft_gau_D2 = H_gauss_D2.*im_ft;
im_gau_D1 = ifft2(ifftshift(ft_gau_D1)); im_gau_D1 = abs(im_gau_D1);
im_gau_D2 = ifft2(ifftshift(ft_gau_D2)); im_gau_D2 = abs(im_gau_D2);
figure();
subplot(1,2,1);
imshow(mat2gray(im_gau_D1)); colormap gray; colorbar; title('Output image for gaussian LPF filter (deviation = 40)');
subplot(1,2,2);
imshow(mat2gray(im_gau_D2)); colormap gray; colorbar; title('Output image for gaussian LPF filter (deviation = 80)');


