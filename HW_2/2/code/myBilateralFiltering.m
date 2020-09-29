function [out_image,RMSD] = myBilateralFiltering(in_image,sig_space,sig_intensity)
    in_image = double(in_image); in_image = in_image/(max(max(in_image)));
    [X,Y] = size(in_image);
    sig = 0.05*(max(max(in_image)) - min(min(in_image))); %standard deviation of gaussian noise
    corr_image = in_image + sig*randn(size(in_image)); %adding noise to the image
    out_image = zeros(X,Y);
    alpha = 0.001;
    d = 1+ceil(sqrt(-2*log(alpha))*sig_space); %window size is (2d+1)X(2d+1)
    for j=1:X
        for k=1:Y
            window = corr_image(max(j-d,1):min(j+d,X),max(k-d,1):min(k+d,Y));
            weight = zeros(size(window));
            for x = max(j-d,1):min(j+d,X)
                for y = max(k-d,1):min(k+d,Y)
                    weight(x-max(j-d,1)+1,y-max(k-d,1)+1) = exp(-((x-j)^2 + (y-k)^2)/(2*sig_space^2))*exp(-(corr_image(x,y)-corr_image(j,k))^2/(2*sig_intensity^2));
                end
            end
            out_image(j,k) = sum(sum(weight.*window))/sum(sum(weight));
        end
    end
    
    d = 5*d; %the size of box is increased to show the gaussian mask properly  
    for x = 1:(2*d+1)
        for y = 1:(2*d+1)
            gauss_mask(x,y) = exp(-((x-d)^2 + (y-d)^2)/(2*sig_space^2));
        end
    end
    gauss_mask = gauss_mask/max(max(gauss_mask));
    figure();
    imshow(gauss_mask); title('Gausian Mask for spatial kernel'); colormap(gray); colorbar;
    
    in_image=in_image; corr_image=corr_image; out_image=out_image;
    figure();
    subplot(1,3,1); imshow(in_image); title('Original Image');
    colormap gray; daspect ([1 1 1]); axis tight; colorbar; 
    subplot(1,3,2); imshow(corr_image); title('Corrupted Image');
    colormap gray; daspect ([1 1 1]); axis tight; colorbar; 
    subplot(1,3,3); imshow(out_image); title('Filtered Image'); 
    colormap gray; daspect ([1 1 1]); axis tight; colorbar; 
    
    diff = in_image - out_image; % difference between filtered and original
    RMSD = sqrt(sum(sum(diff.*diff))/(X*Y));
    %this is the root mean square difference which we want to minimize by
    %selecting appropriate sig_space,sig_intensity for a given image
end
