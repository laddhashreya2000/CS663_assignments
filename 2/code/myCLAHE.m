function out_image = myCLAHE(in_image, limit, windowsize)
    [M,N, channels] = size(in_image);
    out_image = in_image;
    width = floor(windowsize/2);
    for chan = 1:channels
        for i=1:M
            startx = max(1, i-width);
            endx = min(i+width, M);
            for j=1:N
                starty = max(1, j-width);
                endy = min(N, j+width);
                grey = in_image(startx:endx, starty:endy, chan);
                image = f(grey, limit);
                out_image(i, j, chan) = image(i-startx+1,j-starty+1);
            end
        end
    end
end

function out = f(img,limit)
    intensities = 0;
    hist = imhist(img);
    for i=1:length(hist)
        if hist(i) > limit
            intensities = intensities + hist(i) - limit;
            hist(i) = limit;
        end
    end
    new = intensities/256;
    hist = hist +new;
    cdf = cumsum(hist)/sum(hist);
    cdf = (cdf*255);    
    out = cdf(uint8(img) + 1);
end
