function out_image = myLinearContrastStretching(in_image)
    channels = size(in_image, 3);

    out_image = zeros([size(in_image, 1), size(in_image, 2), size(in_image, 3)]);
    for i = 1:channels
        greyscale = in_image(:,:,i);
        min_intensity = min(greyscale(:));
        max_intensity = max(greyscale(:));
        a = 255/(max_intensity - min_intensity);
        b = 255 - (a*max_intensity);
        out_image(:,:,i) = a*in_image(:,:, i) + b;
    end
    out_image = uint8(out_image);

end
