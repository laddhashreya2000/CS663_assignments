function out_image = myUnsharpMasking(in_image,sigma,scale)
    %the blurring parameter 'sigma' and scalling parameter 'scale' are to be mentioned
    [X,Y] = size(in_image);
    %for the gaussian mask, we can assume the mean to be 0
    alpha = 0.001; %taken in order to determine size of the mask
    s = 1+ceil(sqrt(2)*sigma*sqrt(-log(alpha)));
    blur_image = zeros(X,Y);
    alpha = 0.001;
    d = 1+ceil(sqrt(-2*log(alpha))*sigma); %window size is (2d+1)X(2d+1)
    for j=1:X
        for k=1:Y
            window = in_image(max(j-d,1):min(j+d,X),max(k-d,1):min(k+d,Y));
            weight = zeros(size(window));
            for x = max(j-d,1):min(j+d,X)
                for y = max(k-d,1):min(k+d,Y)
                    weight(x-max(j-d,1)+1,y-max(k-d,1)+1) = exp(-((x-j)^2 + (y-k)^2)/(2*sigma^2));
                end
            end
            blur_image(j,k) = sum(sum(weight.*window))/sum(sum(weight));
        end
    end
    unsharp_mask = in_image - blur_image;
    out_image = in_image + scale*unsharp_mask;
    %applying linearly contrast-stretch to the obtained output
    out_image = (out_image-min(min(out_image)))/(max(max(out_image))-min(min(out_image)));
    in_image = (in_image-min(min(in_image)))/(max(max(in_image))-min(min(in_image)));
    figure();
    subplot(1,2,1); imshow(in_image); title('Input Image');
    colormap gray; daspect ([1 1 1]); axis tight; colorbar; 
    subplot(1,2,2); imshow(out_image); title('Output Image');
    colormap gray; daspect ([1 1 1]); axis tight; colorbar; 
%     subplot(1,3,3); imshow(blur_image); title('Blurred Image');
%     colormap gray; daspect ([1 1 1]); axis tight; colorbar; 
end



