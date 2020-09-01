function [mask, out_image] = myForegroundMask(in_image)
    [M,N] = size(in_image);
    mask = zeros(M,N);
    out_image = zeros(M,N);
    
    %threshold is 12 after hit and trial
    for i=1:M
        for j=1:N
            if(in_image(i,j)>=12)
                mask(i, j) = 255;
            else
                mask(i,j) = 0;
            end
            out_image(i,j) = in_image(i,j)*(mask(i,j)/255);
        end
    end
    out_image = uint8(out_image);

end
