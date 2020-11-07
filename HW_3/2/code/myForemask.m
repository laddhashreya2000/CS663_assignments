function [mask, out_image] = myForemask(in_image)
%     in_image=rgb2gray(in_image);
    in_image=in_image(:,:,1);
    imwrite(in_image,"hg.jpg");
    [M,N] = size(in_image);
    mask = zeros(M,N);
    out_image = zeros(M,N);
    disp(M);
    %threshold is 12 after hit and trial
    for i=1:M
        for j=1:N
            if(in_image(i,j)>100)
                mask(i, j) = 255;
            else
                mask(i,j) = 0;
            end
            out_image(i,j) = (in_image(i,j))*(mask(i,j)/255);
        end
    end
    out_image = uint8(out_image);
%     out_image=out_image(:, :, 1);
%     imwrite(out_image,"A.jpg");
%     imwrite(mask,"maskbird.jpg");
      imshow(mask);
end