%% MyMainScript

tic;
%% Your code hereclear all; close all;

im = load('image_low_frequency_noise'); im = im.Z; im = mat2gray(im);
imshow(im);
[m,n] = size(im); title('Original image with low frequency noisy');
%% In this section, we will plot the fourier transform of the image
im_ft = fftshift(fft2(im));
im_ft_mag = abs(im_ft);
im_ft_log = log(1+im_ft_mag);
figure();
imshow(mat2gray(im_ft_log)); colormap jet; colorbar; title('Log magnitude of the Fourier transform');
%% Frequency of noise pattern and interfering frequencies
R_centre = 6; %the centre pixels that can be ignored
frac = 0.8; %by R_centre distance, the magnitude drops by frac
reject_points = zeros(0,2);
centre = ceil([m/2,n/2]); max_val = max(im_ft_log(:));
for x = 1:m
    for y = 1:n
        if ((x-centre(1))^2 + (y-centre(2))^2 >= R_centre^2) && (im_ft_log(x,y)>=frac*max_val)
            reject_points(end+1,:) = [x,y];
        end
    end
end    


%% Ideal notch filter implementation
R = 1;
n_rejects = size(reject_points,1);
H_nr = ones(m,n);
for j = 1:n_rejects
    H = ones(m,n);
    for x = 1:m
        for y = 1:n
            if (x-reject_points(j,1))^2 + (y-reject_points(j,2))^2 <= R^2
                H(x,y) = 0;
            end
        end
    end
    H_nr = H_nr.*H;
end
filt_im_ft = H_nr.*im_ft;
filt_im_ft_log = log(1+abs(filt_im_ft));
figure();
imshow(mat2gray(filt_im_ft_log)); colormap jet; colorbar; title('Fourier transform log magnitude of filtered image');
filt_im = ifft2(ifftshift(filt_im_ft));
figure();
imshow(filt_im); title('Final filtered image');

%% The low frequency noise pattern shown separately
noise_ft = zeros(m,n);
for j = 1:n_rejects
    noise_ft(reject_points(j,1),reject_points(j,2)) = im_ft(reject_points(j,1),reject_points(j,2));
end
noise_im = ifft2(ifftshift(noise_ft));
figure();
imshow(mat2gray(noise_im)); title('Noise pattern in the original image');
toc;
