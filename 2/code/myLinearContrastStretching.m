function out_image = myLinearContrastStretching(in_image)
    channels = size(in_image, 3);

    out_image = in_image;
    for i = 1:channels
        greyscale = in_image(:,:,i);
        min_intensity = min(greyscale(:));
        max_intensity = max(greyscale(:));
        a = 255/(max_intensity - min_intensity);
        b = 255 - (a*max_intensity);
        out_image(:,:,i) = a*in_image(:,:, i) + b;
    end
        
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]' ];
    subplot(1,2,1), imagesc(in_image); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar;
    subplot(1,2,2); imagesc(out_image); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar; 

end